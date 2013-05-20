class SessionsController < ApplicationController
  def create
    @user = User.authenticate(params[:username], params[:password])
    if @user
      session[:user] = @user
      flash[:notice] = "Successfully logged in."
      redirect_to :back
    else
      flash[:error] = 'Invalid username or password. <a href="/users/get_reset_key">Forgot your password?</a>'.html_safe
      redirect_to :back
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out."
    redirect_to :root
  end
end
