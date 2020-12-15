class TasksController < ApplicationController

  # skip_before_action :verify_authenticity_token, :only => [:create]
  protect_from_forgery :only => [:create]

  def index
    @task_all = Task.all
    render json: @task_all
  end

  def show
    @task = Task.all.find(params[:id])
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task
    end
  end

  def update
    @task = Task.all.find(params[:id])
    if @task.update(task_params)
      render json: @task
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    render json: {}
  end

  private
  def task_params
    params.require(:task).permit(:title, :done)
  end

end
