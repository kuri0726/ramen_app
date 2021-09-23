class SearchController < ApplicationController

  before_action :logged_in_user
  attr_accessor :average
  
  def search
    @stores = Store.search(params[:keyword])
    if params[:search] == "all"
      @stores
    elsif params[:search] == "score"
      @stores = @stores.sort_by { |store| store.microposts.average(:score).to_f }.reverse
    elsif params[:search] == "post"
      @stores = @stores.sort_by { |store| store.microposts.count }.reverse
    elsif params[:search] == "like"
      @stores = @stores.sort_by { |store| store.likes.count }.reverse
    end  
    @stores = Kaminari.paginate_array(@stores).page(params[:page]).per(15)
    @keyword = params[:keyword]
    render "/search/search"
  end
end
