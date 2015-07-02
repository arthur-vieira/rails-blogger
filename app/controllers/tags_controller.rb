class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy] # we need to prevent unauthenticated users from deleting the tags, so we protect just the action "destroy"

  def index
    @tags = Tag.all
  end
  def show
    @tag = Tag.find(params[:id])
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash.notice = "Tag '#{@tag.name}' Deleted!"
    redirect_to tags_path
  end
end
