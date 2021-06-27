class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      id = session[:user_id]
      redirect_to :controller => "posts", :action => "index"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
