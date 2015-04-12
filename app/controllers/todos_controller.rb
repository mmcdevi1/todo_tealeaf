class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    @todos = current_user.todos.all
    @todo = current_user.todos.new
  end

  def show
  end

  def new
    @todo = current_user.todos.new
  end

  def edit
  end

  def create
    @todo = current_user.todos.new(todo_list_params)
    if @todo.save_with_tags
      flash[:success] = "Todo list was saved."
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_list_params
    params.require(:todo).permit(:name, :description)
  end

  
end
