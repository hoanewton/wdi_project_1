class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:current_user] = user.id
      flash[:notice] = "You're now logged in!"
      redirect_to users_path
    else
      flash[:notice] = "Login failed: incorrect username and/or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:current_user] = nil
    flash[:notice] = "You're now logged out!"
    redirect_to login_path
  end
end
