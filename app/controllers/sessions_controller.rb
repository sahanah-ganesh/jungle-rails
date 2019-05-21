class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.user_authenticated(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      #redirect to login form if login doesn't work
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
