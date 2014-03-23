class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_url, notice: "My son! You have returned!"
    else
      flash.now.alert = "Mali yan. Fix yourself."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "FINE! Corny naman tasks mo! >:P"
  end
end
