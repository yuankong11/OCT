class TasklistsController < ApplicationController

  # skip_before_action :verify_authenticity_token, :only => [:create]
  protect_from_forgery :only => [:create]

  def index
    @todolist_all = Tasklist.all
    render json: @todolist_all
  end

  def show
    @alist = Tasklist.all.find(params[:uid])
    render json: @alist
  end

  def create
    @new_tasklist = Tasklist.new(tasklist_params)
    if @new_tasklist.save
      render json: @new_tasklist
    end
  end

  def update
    @update_list = Tasklist.all.find(params[:uid])
    if @update_list.update(tasklist_params)
      render json: @update_list
    end
  end

  def destroy
    @tasklist = Tasklist.all.find(params[:uid])
    @tasklist.destroy
    render json: {}
  end

  private
  def tasklist_params
    params.require(:tasklist).permit(:title)
  end

end
