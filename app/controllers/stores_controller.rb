class StoresController < ApplicationController

  before_action :admin_user, {only: [:index, :destroy, :new, :create, :edit, :update]}
  before_action :logged_in_user
  before_action :store_info, {only: [:show, :microposts, :photos, :waiting_time]}
  before_action :photo_index, {only: [:show, :microposts, :photos, :waiting_time]}
  before_action :store_like, {only: [:show, :microposts, :photos, :waiting_time]}

  include StoresHelper

  def show
  end

  def index
    @stores = Store.paginate(page: params[:page])
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "店舗登録が完了しました。"
      redirect_to @store
    else 
      flash.now[:danger] = "入力内容をご確認ください。"
      render "/stores/new"
    end
  end

  def edit
    @store = Store.find_by(id: params[:id])
  end
  
  def update
    @store = Store.find_by(id: params[:id])
    if @store.update(store_params)
      flash[:success] = "店舗情報を更新しました。"
      redirect_to @store 
    else
      flash.now[:danger] = "入力内容を確認してください。"
      render "/stores/edit"
    end
  end

  def destroy
    Store.find_by(id: params[:id]).destroy
    flash[:success] = "店舗情報を削除しました。"
    redirect_to stores_path
  end

  def microposts
    @microposts = @store.store_feed.paginate(page: params[:page], per_page: 10)
  end

  def photos
  end

  def waiting_time
    24.times do |n|
      instance_variable_set('@microposts_' + n.to_s, @store.microposts.microposts_counter(n).count)
    end
    if (params[:week].nil? && params[:time].nil?) || (params[:week] == "" && params[:time] == "")
      @waiting_time = "レビューなし"
      @time = "未選択"
      @week = "未選択"
    else
      if @store.microposts.set_time(params[:time]).set_week(params[:week]).average(:waiting_time)
        @microposts = @store.microposts.set_time(params[:time]).set_week(params[:week]).paginate(page: params[:page], per_page: 10)
        waiting_time = @store.microposts.set_time(params[:time]).set_week(params[:week]).average(:waiting_time).round
        @waiting_time = "推定 #{waiting_time}分"
      else
        @waiting_time = "レビューなし"
      end
      select_week(params[:week])
      select_from_to(params[:time])
    end
    render "/stores/waiting_time"
  end

  private

    def store_params
      params.require(:store).permit(:name, :kana, :address, :telephone_number, :business_hours, :holiday, :menu)   
    end

    def store_info
      @store = Store.find_by(id: params[:id])
      @microposts_count = @store.store_feed.count
      store_microposts = @store.store_feed
      if store_microposts.empty?
        store_microposts = false
      else
        @avg_score = store_microposts.average(:score).round(1)
      end
    end

    def micropost_params
      params.permit(:ate_food, :visit_date, :visit_time, :score, :waiting_time, :content)   
    end

    def photo_index
      @microposts_photos = @store.store_feed.paginate(page: params[:page], per_page: 21)
      @photo_counter = []
      microposts_photos = @store.store_feed
      microposts_photos.each do |microposts_photo|
        if microposts_photo.store_image.attached? 
          @photo_counter.push(microposts_photo.store_image)
        elsif !microposts_photo.micropost_image.empty? && microposts_photo.micropost_image != "no_image.png"
          @photo_counter.push(microposts_photo.micropost_image)
        end
      end
    end

    def store_like
      @liked = Like.find_by(user_id: @current_user.id ,store_id: params[:id])
    end
    
  
end
