class LikesController < ApplicationController

  before_action :logged_in_user

  def create
    @store = Store.find_by(id: params[:id])
    session[:return_to] = request.referer || store_path(@store)
    @like = Like.new(user_id: params[:user_id], store_id: params[:id])
    if @like.save
      respond_to do |format|
        format.html { redirect_to session[:return_to] }
        format.js
      end
    else
      return if Like.find_by(user_id: @current_user.id, store_id: params[:id])
      flash[:danger] = "すでにお気に入り登録しています。"
      redirect_to session[:return_to]
    end
  end

  def destroy
    Like.find_by(user_id: @current_user.id, store_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to session[:return_to] }
      format.js
    end
  end
  
end
