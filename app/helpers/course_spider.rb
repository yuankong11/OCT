module CourseSpider
  include SpiderBase

  # 返回一个 Hash，包含 code, link, name, id 四个数据，都是 String 类型，例如
  # {
  #   "code"=>"178206",
  #   "address"=>"https://course.ucas.ac.cn/portal/site/178206",
  #   "name"=>"中国特色社会主义理论与实践研究（西区）20-21秋季",
  #   "id"=>"030500MGB001H-21"
  # }
  def switch_identity(res)
    other_users = res.links
      .select { |link| link.href =~ /anotherUser/ }
      .map { |link| link.text }
    unless other_users.empty?
      another_user = other_users[0]
      params = {
        "anotherUser" => another_user
      }
      res = @agent.get(COURSE_INFO_URL_S, params, COURSE_INFO_URL_S, HEADER)
    end
    return res
  end

  def get_courses
    if login_sep == :fail
      raise StandardError, "get courses failed"
    end
    params = {
      "Identity" => @identity,
      "roleId" => 801
    }
    res = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)
    res = switch_identity(res)

    find_data_site_id = /site\/(\d{6})$/
    course_infos = res.links
      .select { |link| link.href =~ find_data_site_id }
      .map { |link|
        {
          "code" => link.href.scan(/\d{6}/)[0],
          "address" => link.href,
          "name" => link.attributes['title'],
          "id" => link.text.scan(/[a-zA-Z0-9-]{10,20}/)[0]
        }
      }.uniq
    return course_infos
  end
end
