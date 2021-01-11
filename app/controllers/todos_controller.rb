class TodosController < ApplicationController

    # skip_before_action :verify_authenticity_token, :only => [:create]
    protect_from_forgery :only => [:create]

    def index
        @todo_all = Todo.all
        render json: @todo_all
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
        @todo = Todo.all.find(params[:uid])
        if @todo.update(todo_params)
            render json: @todo
        end
    end

    def destroy
        todo = Todo.find(params[:uid])
        todo.destroy
        render json: {}
    end

    private
    def todo_params
        params.require(:todo).permit(:title, :done, :flag, :duetime)
    end

end
