class SearchController < ApplicationController

  before_action :logged_in_user
  
  def search
    @stores = Store.search(params[:keyword]).paginate(page: params[:page], per_page: 20)
    @keyword = params[:keyword]
    render "/search/search"
  end
end
