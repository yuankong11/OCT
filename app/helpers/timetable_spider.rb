require 'icalendar'
require 'open-uri'

module TimetableSpider
  include SpiderBase

  def get_ics_url
    params = {
      "Identity" => @identity,
      "roleId" => 801
    }
    main_page = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)
    schdl_link = main_page.search("//span[@class='Mrphs-toolsNav__menuitem--icon icon-sakai--sakai-schedule']/..")
    schdl_page = @agent.click(schdl_link)
    puts schdl_page.body
    ics_link = schdl_page.search("//a[@title='生成在其他日程应用中使用的私有链接']")
    ics_click = @agent.click(ics_link)
    ics_url = ics_click.search("//div[@class='portletBody']/p[@class='shorttext indnt2' and position()>1]/a[@target='_new_']").attributes["href"]
    return ics_url
  end

#  def get_timetable_overview
#    params = {
#      "Identity" => @identity,
#      "roleId" => 801
#    }
#    main_page = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)
#    schdl_link = main_page.search('//span[@class='Mrphs-toolsNav__menuitem--icon icon-sakai--sakai-schedule']/..')
#    schdl_page = @agent.click(schdl_link)
#    puts schdl_page.body
#    csrf_token = schdl_page.search('//input[@name='sakai_csrf_token']').attributes["value"].value
#    view_week_form = schdl_page.form_with((:name => 'viewForm') do |form|
#      form.eventSubmit_doView = 'view'
#      form.view = '按周显示日程表'
#      form.sakai_csrf_token = csrf_token
#    end.submit

#    web_timetable = view_week_form.search('//table[@class='calendar']')
#    web_classes = web_timetable.search('//td[@class='borderGrayBackground']/div/a')
#    classes = web_classes.map {
#      |class|{
#        "title" => class.attributes['title'].scan(/([^>]*) - [^>]*/)[0][0]
#        "info_link" => class.attributes['href']=='\#'? class.attributes['onclick'].scan(/location\=\'([^>]*)\';return false;/)[0][0] : class.attributes['href']
#      }
#    }
#    return classes
#  end

  # def get_timetable_detail
  #  timetable = get_timetable_overview.map
  #  {|class|
  #   class_detail = @agent.get(class["info_link"])
  #    {
  #      "cid" => class_detail # 课程编号
  #      "title" => class["title"], # 课程名
  #      "room" => # 上课地点
  #      "dtstart" => # 开始时间
  #      "dtend" => # 结束时间
  #      "type" => # 事件类型
  #    }
  #  }
  #end

  def get_timetable
  end
end
