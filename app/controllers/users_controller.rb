class UsersController < ApplicationController
  before_action :verify_password_mismatch, only: [:create]


  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Created Account, #{user.email}!"
      redirect_to links_path
    else
      flash[:warning] = "oops"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def verify_password_mismatch
    if !password_verified('user')
      flash[:warning] = 'Passwords must be the same'
      redirect_to new_user_path
    end
  end


end
