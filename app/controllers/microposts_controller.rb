class MicropostsController < ApplicationController

  before_action :logged_in_user
  before_action :correct_user_destroy , {only: [:destroy]}

  def review
    @store = Store.find_by(id: params[:id])
    @micropost = @current_user.microposts.build
  end

  def create
    @store = Store.find_by(id: params[:id])
    @micropost = @current_user.microposts.build(micropost_params)
    @micropost.week = params[:micropost][:visit_date].to_time.wday
    @micropost.micropost_image = "no_image.png"
    if @micropost.save
      if params[:micropost][:store_image]
        @micropost.store_image.attach(params[:micropost][:store_image])
        @store.store_image.attach(params[:micropost][:store_image])
      end
      flash[:success] = "レビューを投稿しました。"
      redirect_to store_microposts_path(@store)
    else
      flash.now[:danger] = "入力内容を確認してください。"
      render "/microposts/review"
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
  end

  def destroy
    Micropost.find_by(id: params[:id]).destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to @current_user
  end

  private

    def micropost_params
      params.require(:micropost).permit(:ate_food, :visit_date, :visit_time, :score, :waiting_time, :content, :store_id)   
    end

    def correct_user_destroy
      @micropost = Micropost.find(params[:id])
      unless @micropost.user.id == @current_user.id
        flash[:danger] = "無効な処理です。"
        redirect_to @current_user  
      end
    end

end
