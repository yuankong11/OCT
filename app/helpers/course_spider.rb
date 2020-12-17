module CourseSpider
  include SpiderBase

  def get_courses
    params = {
      "Identity" => @identity,
      "roleId" => 801
    }
    res = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)

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

    find_data_site_id = /site\/(\d{6})$/
    codes = res.links
      .map { |link| link.href }
      .select { |link| link =~ find_data_site_id }
      .map { |link| link.scan(/(\d{6})/)[0][0] }
    return codes
  end
end
