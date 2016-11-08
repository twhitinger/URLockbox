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
      flash[:warning] = "Link must be valid format and all inputs filled in"
      redirect_to root_path
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if params[:link] && @link.update(link_params)
      redirect_to links_path
      flash[:success] = "Updated your link"
    elsif params[:link]
      redirect_to links_path
      flash[:warning] = @link.errors.full_messages.join(', ')
    else
      @link.update_attributes(read: !@link.read)
        render json: [@link, @link.tags]
    end
  end

  def destroy
    link = Link.where(user: current_user, id: params[:id])
    link.destroy_all
    redirect_to links_path
  end

  private

  def link_params
      params.require(:link).permit(:url, :title, :user_id, :tag_list)
  end

end
