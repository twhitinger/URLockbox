class LinksController < ApplicationController
  def index
    redirect_to login_path if !current_user
    @links = Link.where(user: current_user)
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      flash[:success] = "Link to #{@link.title} added to your repo."
      redirect_to links_path
    else
      flash[:warning] = "oops"
      redirect_to root_path
    end
  end

    def update
      @link = Link.find(params[:id])
      @link.update_attributes(read: invert)
      redirect_to links_path
    end

    private
    def link_params
      params.require(:link).permit(:url, :title, :user_id)
    end

    def invert
      if @link.read
        false
      else
        true
      end
    end
  end
