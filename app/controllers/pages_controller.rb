class PagesController < ApplicationController
  def front
    redirect_to todos_path if logged_in?
  end
end