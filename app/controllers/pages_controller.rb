class PagesController < ApplicationController
  def index
    @search = OpenStruct.new(params[:search])
    @pages = Page.all
  end

  def create
    page_id = search_params[:facebook_id]
    fb_page = PageFetcher.find(page_id)
    page = Page.new fb_page
    if page.save
      puts "==not=="
      redirect_to pages_path
    else
      puts "==notice=="
      redirect_to pages_path, notice: "Error"
    end
  end

  private

  def search_params
    params.require(:search).permit(:facebook_id)
  end
end
