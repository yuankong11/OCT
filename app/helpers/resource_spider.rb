module ResourceSpider
  include CourseSpider

  RESOURCE_URL_S = "https://course.ucas.ac.cn/access/content/group/"

  def get_resources(course_code)
    course_link = RESOURCE_URL_S + course_code
    res = agent.get(course_link)
    file_infos = res.links.map do |link|
      {
        "name" => link.text,
        "address" => course_link + link.href
      }
    end
    return file_infos
  end
end
