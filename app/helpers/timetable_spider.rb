require 'icalendar'
module TimetableSpider
  include SpiderBase

  def get_ics_url
    params = {
      "Identity" => @identity,
      "roleId" => 801
    }
    @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER) do |page|
      #puts page.body
      # 进入日程页面
      #main_schdl = @agent.click(page.link_with(:text => /^日程/, :dom_class => "Mrphs-toolsNav__menuitem--link"))
      main_schdl = @agent.click(page.link_with(:dom_class => "Mrphs-toolsNav__menuitem--icon icon-sakai--sakai-schedule"))
      puts main_schdl.body
      # 选择私有发布
      ics_schedl = @agent.click(main_schdl.link_with(:text => "发布（私有）"))
      ics_url = ics_schedl.link_with(:href => /^https:\/\//).text
      return ics_url
    end
  end
end
