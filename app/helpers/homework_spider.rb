module HomeworkSpider
  include CourseSpider

  ATTACH_URL = "https://course.ucas.ac.cn/access/content/attachment/"
  COURSE_URL_S = "https://course.ucas.ac.cn/portal/site/"

  def get_homework
    i = 1
    course_homeworks = get_courses.map do |course|
      puts "course#{i}: " + course["name"]
      i = i + 1
      {
        "name" => course["name"],
        "address" => course["link"],
        "children" => get_homework_from_course(course["code"])
      }
    end

    course_homeworks = course_homeworks.reject{|course| course["children"].empty? || course["children"].nil? }
    puts course_homeworks
    course_homeworks
  end


  # 按课程 code 获取该课程所有的作业并形成一个数组
  def get_homework_from_course(course_code)
    course_link = COURSE_URL_S + course_code
    homework_list_url = nil
    puts 'course_link: ' + course_link
    # 进入课程页面
    res = @agent.get(course_link)
    res = switch_identity(res)
    res = @agent.get(course_link)

    # 寻找作业列表页面的链接
    res.search("nav#toolMenu ul li a span").each do |node|
      if node.content == "作业"
        homework_list_url = node.parent['href']
      end
    end

    if homework_list_url != nil
      puts 'homework_link: ' + homework_list_url
      # 进入作业列表页面获取当前课程的所有作业
      get_homework_from_url(homework_list_url)
    else
      puts 'no homework!'
    end

  end

  # 对课程的作业页面获取所有作业并形成数组
  # name: 作业名称
  # url: 地址
  # status: 作业状态
  # begin: 作业开始时间
  # due: 作业截止时间
  # info: 作业详细说明
  # attachments: 作业附件链接列表
  def get_homework_from_url(url)
    res = @agent.get(url)
    # res = switch_identity(res)
    # res = @agent.get(url)
    homework_infos = res.search("form[name=listAssignmentsForm] tr")
    homework_infos
      .reject { |node| node.content =~ /作业标题/ } # 删除表头
      .map do |node|
      puts "each node"
      homework_url = node.search("td[headers=title] a")[0]['href']
      homework_info = {
        "name" => node.search("td[headers=title]")[0].content.strip,
        "url" => homework_url,
        "status" => node.search("td[headers=status]")[0].content.strip,
        "begin" => node.search("td[headers=openDate]")[0].content.strip,
        "due" => node.search("td[headers=dueDate]")[0].content.strip
      }

      # 进入当前作业的详细页面
      puts 'homework detail link: ' + homework_url
      details = get_homework_detail_from_url(homework_url)
      if details["name"] != homework_info["name"]
        homework_info["name"] = details["name"]
      end
      homework_info["info"] = details["info"]
      homework_info["attachments"] = details["attachments"]

      puts 'cur_homework_info'
      puts homework_info
      homework_info
    end
  end

  def get_homework_detail_from_url(url)
    res = @agent.get(url)
    # res = switch_identity(res)
    # res = @agent.get(url)

    if (homework_summary = res.search("table.itemSummary")[0])
      homework_name = homework_summary.search("tr td")[0].content.strip
    else
      homework_summary = res.search("div.itemSummary")[0]
      homework_name = homework_summary.search(".itemSummaryValue")[0].content.strip
    end

    puts res.search("h4+ul.attachList a")

    # 获得附件
    homework_attachments = res.search("h4+ul.attachList a").map do |link|
      # 注意区分作业指导附件和提交附件
      puts "enter attach!"
      {
        "attachment_name" => link.content,
        "attachment_url" => link["href"]
      }
    end

    homework_description = res.search(".textPanel")[0]
    if homework_description != nil
      homework_description = res.search(".textPanel")[0].content.strip
    else
      homework_description = "无。"
    end

    # 返回作业详情信息字典
    {
      "name" => homework_name,
      "info" => homework_description,
      "attachments" => homework_attachments
    }
  end

  private :get_homework_from_course, :get_homework_from_url, :get_homework_detail_from_url
end
