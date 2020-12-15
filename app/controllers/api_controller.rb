class ApiController < ApplicationController
  include ApiHelper

  def function_dispatch
    send(params[:function])
  end

  def courses
    @courses = spider.get_courses
    spider.quit
  end

  def login
    certer = Certer.new("Milky2020", "lzy19980424")
    spider = Spider.new("leizhengyu16@mails.ucas.ac.cn", "lzy19980424", :chrome, certer)
    if spider.login_sep == :success
      render json: "success"
    else
      render json: "fail"
    end
  end
end
