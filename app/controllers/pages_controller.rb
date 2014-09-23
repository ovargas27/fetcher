class PagesController < ApplicationController
  def index
    @search = OpenStruct.new(params[:search])
    @pages = Page.all
  end

  def create
    page = Page.search search_params
    if page.present?
      redirect_to pages_path
    else
      redirect_to pages_path, alert: "Facebook Page doesn't exist"
    end
  end

  private

  def search_params
    params.require(:search).permit(:facebook_id)
  end
end
