class StoresController < ApplicationController

  before_action :admin_user, {only: [:index, :destroy, :new, :create, :edit, :update]}
  before_action :logged_in_user

  def show
    @store = Store.find(params[:id])
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
    @store = Store.find_by(id: params[:id])
  end

  def photos
    @store = Store.find_by(id: params[:id])
  end

  def waiting_time
    @store = Store.find_by(id: params[:id])
  end

  def review
    @store = Store.find_by(id: params[:id])
  end

  private

    def store_params
      params.require(:store).permit(:name, :kana, :address, :telephone_number, :business_hours, :holiday, :menu)   
    end

end
