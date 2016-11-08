class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    tag = Tag.where(user: current_user, id: params[:id])
    tag.destroy_all
  end
end
