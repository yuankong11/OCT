module ApiHelper
  def from_url_to_path(url)
    resource_path = "./app/assets/resources/"
    return (resource_path + URI.decode(url)).gsub("https://course.ucas.ac.cn/access/content/group/", "")
  end

  class Spider
    require 'mechanize'

    include HomeworkSpider
    include ResourceSpider
    include LiveLessonSpider
    include LectureSpider

    def initialize(username, password)
      @username = username
      @password = password
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Mac Safari'
      @agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @agent.redirect_ok = :all
    end

    def login_sep
      query = {
        'username' => @username,
        'password' => @password,
        'remember' => 'undefined'
      }
      res = @agent.post(LOGIN_URL_S, query, HEADER)
      if JSON.parse(res.body)["f"]
        msg = JSON.parse(res.body)["msg"]
        @identity = msg.scan(/Identity=(.*?)$/)[0]
        return :success
      else
        return :fail
      end
    end

    def logout
      # todo: 退出登录
    end

    def logged_in?
      if defined? @identity
        params = {
          "Identity" => @identity,
          "roleId" => 801
        }
        res = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)
        return res.title != "SEP 教育业务接入平台"
      else
        return false
      end
    end

    def quit
      logout
      # todo: 销毁spider
    end
  end
end
