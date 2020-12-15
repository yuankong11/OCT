class ApiController < ApplicationController
  protect_from_forgery :only => [:login]

  include ApiHelper

  def function_dispatch
    send(params[:function])
  end

  def module_function_dispatch
    t = eval("#{params[:module]}.new")
    t.send(params[:function])
  end

  def courses
    @courses = spider.get_courses
    spider.quit
  end

  def login
    certer = Certer.new("Milky2020", "lzy19980424")
    spider = Spider.new(params[:username], params[:password], :chrome, certer)
    if spider.login_sep == :success
      render json: "success"
    else
      render json: "fail"
    end
  end
end
