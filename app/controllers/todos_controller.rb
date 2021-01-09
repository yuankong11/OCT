class TodosController < ApplicationController

    # skip_before_action :verify_authenticity_token, :only => [:create]
    protect_from_forgery :only => [:create]

    def index
        @tasklist_all = Tasklist.all
        render json: @tasklist_all
    end

    def show
        @todo = Todo.all.find(params[:uid])
        render json: @todo
    end

    def create
        @todo = Todo.new(todo_params)
        if @todo.save
            render json: @todo
        end
    end

    def update
        @task = Task.all.find(params[:uid])
        if @task.update(task_params)
            render json: @task
        end
    end

    def destroy
        task = Task.find(params[:uid])
        task.destroy
        render json: {}
    end

    private
    def task_params
        params.require(:todo).permit(:title, :done)
    end

end
