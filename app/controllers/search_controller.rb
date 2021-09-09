class SearchController < ApplicationController

  before_action :logged_in_user
  before_action :recent_micropost
  
  def search
    @stores = Store.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render "/search/search"
  end
end
