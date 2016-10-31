class SessionsController < ApplicationController
  def new
    redirect_to links_path if current_user
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Hello, #{@user.email}"
      redirect_to links_path
    else
      flash.now[:warning] = "Login incorrect"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
