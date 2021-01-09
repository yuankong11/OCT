module HomeworkSpider
  include CourseSpider

  ATTACH_URL = "https://course.ucas.ac.cn/access/content/attachment/"
  COURSE_URL_S = "https://course.ucas.ac.cn/portal/site/"

  require 'nokogiri'

  def get_homework
    puts 'hi'
    get_courses.map do |course|
      {
        "name" => course["name"],
        "address" => course["link"],
        "children" => get_homework_from_course(course["code"]),
        "file" => "folder"
      }
    end
  end

  def download_file(url, path)
    unless File.exist?(path)
      get_courses
      @agent.get(url).save(path)
    end
  end

  # 按课程 code 获取该课程所有的作业并形成一个数组
  def get_homework_from_course(course_code)
    course_link = COURSE_URL_S + course_code

    homework_url = nil

    puts 'course_link: ' + course_link
    res = @agent.get(course_link)
    puts 'res: '
    puts res
    res.search("nav#toolMenu ul li a span").each do |node|
      puts node
      if node.content == "作业"
        homework_url = node.parent['href']
      end
    end

    puts homework_url
    get_homework_from_url(homework_url)
  end

  # 对课程的作业页面获取所有作业并形成数组
  # name: 资源名称
  # address: 地址
  # children: 子资源
  # file: 文件格式
  def get_homework_from_url(url)
    res = @agent.get(url)

    homework_infos = res.search("form[name=listAssignmentsForm] tr")
      .reject {|node| node.content}
      .map do |node|
        homework_info = {
          "name" => node.search("td[headers=title]")[0].content,
          "url" => node.search("td[headers=title] a")[0]['href'],
          "status" => node.search("td[headers=status]")[0].content.strip,
          "begin" => node.search("td[headers=openDate]")[0].content.strip,
          "end" => node.search("td[headers=dueDate]")[0].content.strip
        }
        puts homework_info
        if link.href =~ /\/$/
          details = get_homework_detail_from_url(url + link.href)
          homework_info["children"] = details["detail"]
          homework_info["attachment"] = details["attachment"]
          # elsif postfixs = link.text.scan(/\.(\w+)$/)[0]
          #   file_info["file"] = postfixs[0]
          # else
          #   file_info["file"] = "unknown"
      end
    end

    homework_infos
  end

  def get_homework_detail_from_url(url) end

  private :get_homework_from_course, :get_homework_from_url
end
