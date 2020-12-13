class FrontendController < ApplicationController
  include FrontendHelper

  def home
    redirect_to '/app/dashboard'
  end

  def show
    @postfix = params[:postfix]
  end

  def courses
    certer = Certer.new("Milky2020", "lzy19980424")
    spider = Spider.new("leizhengyu16@mails.ucas.ac.cn", "lzy19980424", :chrome, certer)
    spider.login_sep
    @courses = spider.get_courses
    spider.quit
  end

  def tasks
    @tasks_all = Task.all
  end

end
