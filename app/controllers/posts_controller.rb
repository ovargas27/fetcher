class PostsController < ApplicationController
  def index
    @page = Page.find params[:page_id]
  end
end
