class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_list_params)
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
