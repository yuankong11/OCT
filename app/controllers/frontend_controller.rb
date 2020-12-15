class FrontendController < ApplicationController
  include FrontendHelper

  def home
    redirect_to '/app/dashboard'
  end

  def show
    @postfix = params[:postfix]
  end

  def tasks
    @tasks_all = Task.all
  end
end
