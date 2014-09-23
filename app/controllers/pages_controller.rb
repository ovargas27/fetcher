class PagesController < ApplicationController
  def index
    @page = Page.new
    @pages = Page.all
  end

  def create
    page_id = search_params[:facebook_id]
    fb_page = PageFetcher.find(page_id)
    page = Page.new fb_page
    page.save
    redirect_to pages_path
  end

  private

  def search_params
    params.require(:page).permit(:facebook_id)
  end
end
