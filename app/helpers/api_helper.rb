require 'icalendar'
require 'open-uri'

module ApiHelper
  def resources_update(username, resources_list)
    user = User.find_by(email: username)
    resources_list.each do |obj|
      path = FileRecord.address_to_path(obj["address"])
      is_course = obj["file"] == "course"
      name = obj["name"]
      has_children = obj["file"] == "folder" || is_course
      f = FileRecord.find_by(user: user, path: path)
      if f
        if f.has_children != has_children
          f.update_attributes(has_children: has_children)
        end
      else
        FileRecord.create(user: user, has_children: has_children, unread: true, path: path, course: is_course, name: name)
      end
      if has_children
        resources_update(username, obj["children"])
      end
    end
  end

  def find_resources(username)
    user = User.find_by(email: username)
    records = FileRecord.where(user: user)
    records.select do |r|
      r.course
    end.map do |f|
      FileRecord.record_to_hash(f, records)
    end
  end

  def analyze_timetable
    #puts current_user
    @user = User.find_by(email: current_user)
    # 把每个人的ics链接存放到模型中方便之后读取
    ics_url = current_spider.get_ics_url
    if !ics_url.nil?
      @user.update(timetable_ics: ics_url)
      cal = Icalendar.parse(open(ics_url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read) #ics解析
      puts "-----------cal.first------------"
      puts cal.first
      puts "-----------cal.first.event------------"
      puts cal.first.event
      return cal.first.events
    end
  end

  class Spider
    # require 'mechanize'

    include HomeworkSpider
    include ResourceSpider
    include LiveLessonSpider
    include LectureSpider
    include TimetableSpider

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
        res = @agent.get(COURSE_INFO_URL, params, ONESTOP_URL_S, HEADER)
        return res.title != "Course : Gateway : Welcome"
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
