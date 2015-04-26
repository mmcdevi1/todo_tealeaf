class SessionsController < ApplicationController
  def create
    user = User.where(username: params[:username]).first
    session[:user_id] = user.id
    redirect_to current_user.admin? ? admin_todos_path : todos_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end