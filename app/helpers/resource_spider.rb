module ResourceSpider
  include CourseSpider

  RESOURCE_URL_S = "https://course.ucas.ac.cn/access/content/group/"

  def get_resources
    get_courses.map do |course|
      {
        "name" => course["name"],
        "address" => course["link"],
        "children" => get_resources_from_course(course["code"]),
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

  # 按课程 code 获取该课程所有的资源并形成一个数组
  def get_resources_from_course(course_code)
    course_link = RESOURCE_URL_S + course_code
    file_infos = get_resources_from_url(course_link + '/')

    return file_infos
  end

  # 对特定地址的目录获取资源并形成数组
  # name: 资源名称
  # address: 地址
  # children: 子资源
  # file: 文件格式
  def get_resources_from_url(url)
    res = @agent.get(url)
    file_infos = res.links
      .reject { |link| ['#', '../'].any? link.href }
      .map do |link|
        file_info = {
          "name" => link.text,
          "address" => url + link.href
        }
        if link.href =~ /\/$/
          file_info["children"] = get_resources_from_url(url + link.href)
          file_info["file"] = "folder"
        elsif postfixs = link.text.scan(/\.(\w+)$/)[0]
          file_info["file"] = postfixs[0]
        else
          file_info["file"] = "unknown"
        end
        file_info
      end
    return file_infos
  end

  private :get_resources_from_course, :get_resources_from_url
end
