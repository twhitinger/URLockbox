class ConnectionsController < ApplicationController
  def index
    redirect_to login_path if !current_user
  end
end
