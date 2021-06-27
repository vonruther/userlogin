class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user

  private

  def require_login
    flash[:danger] = "You do not have authorization to visit this page"
    redirect_to login_path unless session.include? :user_id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def correct_user
   if current_user.id != Post.find(params[:id]).user_id
     flash[:danger] = "You do not have authorization to edit this post" #if not logged in as the owner of the post
     redirect_to posts_path
   end
  end
end
