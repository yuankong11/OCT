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

  def available_ics_url(url)
    rule_https = /^https?:\/\//
    rule_ics = /.ics$/
    if (url.nil? || (url =~ rule_https).nil? || (url =~ rule_ics).nil?)
      return false
    end
    return true
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

    def get_lecture_table(subject, res)
      if subject == 0
        regex = /\/subject\/lecture/
      else
        regex = /\/subject\/humanityLecture/
      end
      page = res.link_with(href: regex).click
      table = /\<tbody\>.*\<\/tbody\>/m.match(page.body).to_s
      trs = table.split("</tr>")
      trs.delete_at(trs.length-1)
      trsa = Array.new
      trs.each do |i|
        tds = i.split("</td>")
        tds.delete_at(tds.length-1)
        tdsa = Array.new
        tds.each do |j|
          content = /\<td\>.*/m.match(j).to_s
          content.force_encoding("utf-8")
          tdsa << content[4,content.length-1]
        end
        tdsa.delete_at(3)
        tdsa.delete_at(5)
        trsa << tdsa
      end
      trsa
    end

    def get_lecture_info
      params = {
        "Identity" => @identity,
      }
      app_store_page = @agent.get(LOGIN_SEP_URL, params, ONESTOP_URL_S, HEADER)
      link_821 = app_store_page.links_with(href: "/portal/site/226/821")[0]
      click_res_821 = link_821.click
      res_821 = click_res_821.link_with(href: /http:\/\/jwxk.ucas.ac.cn\/login\?Identity/).click
      @lecture = Array.new(2)
      @lecture[0] = get_lecture_table(0, res_821)
      @lecture[1] = get_lecture_table(1, res_821)
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
        get_lecture_info
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
