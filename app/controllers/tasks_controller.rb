class TasksController < ApplicationController

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
    if @task.update(task_params)
      render json: @task
    end
  end

  def destroy
    @task.destroy
    render json: {}
  end

  private
  def task_params
    params.require(:task).permit(:title, :done)
  end

end
