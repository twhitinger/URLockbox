class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
  

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #
  # def password_verified(data)
  #   params[data]['password'] == params[data]['verify_password']
  # end
end
