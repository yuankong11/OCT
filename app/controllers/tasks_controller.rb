class TasksController < ApplicationController
    def index
        @task_all = Task.all
        render json: @task_all
    end
    def show
        @task = Task.all.find(params[:id])
        render json: @task
      end

    def new
        @tweet = Tweet.new
    end

    def create
        @newtask = Task.new(task_params)
        if @newtask.save
            render json: @newtask
        end 
    end

    def update
        if @newtask.update(task_params)
            render json: @newtask
        end
    end
    
    def destroy
    end

    private
    def task_params
        params.require(:task).permit(:title, :done)
    end


end
