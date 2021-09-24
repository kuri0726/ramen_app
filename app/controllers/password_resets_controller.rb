class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]  
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to sent_path
    else
      flash.now[:danger] = "登録がないメールアドレスです。"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?                 
      flash.now[:danger] = "パスワードを入力してください。"
      render 'edit'
    elsif @user.update(user_params)                
      log_in @user
      flash[:success] = "パスワードを変更しました。"
      redirect_to @user
    else
      flash.now[:danger] = "無効なパスワードです。"
      render 'edit'                                     
    end
  end

  def sent
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "ユーザーが異なります。"
        redirect_to new_password_reset_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード変更の有効期限が切れています。"
        redirect_to new_password_reset_url
      end
    end

end
