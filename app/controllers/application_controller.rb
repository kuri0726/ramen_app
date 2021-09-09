class ApplicationController < ActionController::Base
  include UsersHelper

  private

  def logged_in_user
    unless logged_in?
      # store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def admin_user
    unless current_user.admin?
      redirect_to @current_user
      flash[:danger] = "権限がありません。"
    end
  end

  def recent_micropost
    @recent_microposts = Micropost.where(store_id: params[:id]).order(created_at: "DESC").limit(1)
    @recent_micropost = @recent_microposts[0]
  end
  

  
end
