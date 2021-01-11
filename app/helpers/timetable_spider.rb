module TimetableSpider
  include SpiderBase

  def get_ics_url
    params = {
      "Identity" => @identity,
      "roleId" => 801
    }
    main_page = @agent.get(LOGIN_COURSE_URL_S, params, ONESTOP_URL_S, HEADER)
    schdl_link = nil
    main_page = switch_identity(main_page)
    schdl_link = main_page.search('//a[@title="日程 - 发布和查看事件，截止日期等"]')[0]
    if schdl_link.nil?
      schdl_link = main_page.search('//nav[@id="toolMenu"]/ul/li[4]/a[@class="Mrphs-toolsNav__menuitem--link "]')[0]
    end
    if schdl_link.nil?
      schdl_link = main_page.search('//span[@class="Mrphs-toolsNav__menuitem--icon icon-sakai--sakai-schedule "]/..')[0]
    end
    schdl_page = @agent.get(schdl_link.attributes["href"].value)
    #puts schdl_page.body
    ics_link = schdl_page.search('//a[@title="生成在其他日程应用中使用的私有链接"]')[0]
    ics_click_link = ics_link.attributes["onclick"].value.scan(/location \= \'([^>]*)\';return false;/)[0][0]
    ics_click = @agent.get(ics_click_link)
    #puts ics_click.body
    ics_url = ics_click.link_with(:text => /^https/).href
    if ics_url.nil? # 未生成，需要post
      csrf_token = ics_click.search('//input[@name="sakai_csrf_token"]')[0].attributes["value"].value
      state = ics_click.search('//input[@name="state"]')[0].attributes["value"].value
      generate_ics = ics_click.form_with(:action => /^https:\/\/course.ucas.ac.cn\//) do |form|
                form.eventSubmit_doOpaqueUrlGenerate = "生成"
                form.state = state
                form.sakai_csrf_token = csrf_token
      end.submit
        ics_click = @agent.get(generate_ics)
        ics_url = ics_click.link_with(:text => /^https/).href
    end
    #puts "！！！ics_url是"
    #puts ics_url
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
