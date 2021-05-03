class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url # halts request cycle
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

end
