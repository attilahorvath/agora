class UsersController < ApplicationController
  def index
    redirect_to :root
  end

  def new
    @user = User.new
  end

  def create
    user_hash = params[:user]
    @user = User.new(:name => user_hash[:name], :email => user_hash[:email])
    
    @user.password = user_hash[:password]
    @user.password_confirmation = user_hash[:password_confirmation]

    if @user.save
      UserMailer.welcome(@user).deliver
      flash[:notice] = "Successfully registered."
      session[:user] = @user
      redirect_to :action => :edit
    else
      render :action => :new
    end
  end

  def show
    @user = User.find params[:id]
    @comments = @user.comments
    @topics = @user.topics
  end

  def edit
    if current_user
      @user = current_user
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def update
    if current_user
      @user = current_user
      @user.update_attributes(params[:user])

      if @user.save
        flash[:notice] = "Options changed."
        redirect_to :action => :edit
      else
        redirect_to :action => :edit
      end
    else
      flash[:error] = "You have to be logged in to access this page."
      redirect_to :root
    end
  end

  def get_reset_key
    if current_user
      flash[:error] = "You have to log out to access this page."
      redirect_to :root
    end
  end

  def send_reset_key
    if current_user
      flash[:error] = "You have to log out to access this page."
      redirect_to :root
    else
      @user = User.find_by_email params[:email]
      if @user
        @user.reset_key = Digest::SHA1.hexdigest Time.now.to_s + Random.rand.to_s
        @user.save
        UserMailer.reset_key(@user).deliver
        flash[:notice] = "Reset key sent."
        redirect_to :root
      else
        flash[:error] = "Invalid address."
        redirect_to :back
      end
    end
  end

  def reset_password
    if current_user
      flash[:error] = "You have to log out to access this page."
      redirect_to :root
    else
      @user = User.find params[:id]
      if @user && @user.reset_key == params[:reset_key]
        @user.reset_key = nil
        @user.save
        session[:user] = @user
        flash[:notice] = "You can now enter a new password."
        redirect_to :edit_user
      else
        flash[:error] = "Invalid user ID or reset key."
        redirect_to :root
      end
    end
  end
end
