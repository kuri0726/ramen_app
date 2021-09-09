class MicropostsController < ApplicationController

  before_action :logged_in_user
  before_action :recent_micropost

  def review
    @store = Store.find_by(id: params[:id])
    @micropost = @current_user.microposts.build
  end

  def create
    @store = Store.find_by(id: params[:id])
    @micropost = @current_user.microposts.build(micropost_params)
    @micropost.micropost_image = "/no_image.png"
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

  private

    def micropost_params
      params.require(:micropost).permit(:ate_food, :visit_date, :visit_time, :score, :waiting_time, :content, :store_id)   
    end

end
