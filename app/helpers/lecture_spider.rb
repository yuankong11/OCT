module LectureSpider
  include SpiderBase

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
    if defined? @lecture
      return
    end
    login_sep
    params = {
      "Identity" => @identity,
    }
    link_821 = nil
    while link_821.nil?
      app_store_page = @agent.get(LOGIN_SEP_URL, params, ONESTOP_URL_S, HEADER)
      link_821 = app_store_page.links_with(href: "/portal/site/226/821")[0]
    end
    click_res_821 = link_821.click
    res_821 = click_res_821.link_with(href: /http:\/\/jwxk.ucas.ac.cn\/login\?Identity/).click
    @lecture = Array.new(2)
    @lecture[0] = get_lecture_table(0, res_821)
    @lecture[1] = get_lecture_table(1, res_821)
  end

  def lecture
    @lecture
  end
end
