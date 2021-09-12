class UsersController < ApplicationController

  before_action :logged_in_user, {only: [:edit, :update, :index, :show, :destroy, :microposts]}
  before_action :user_info, {only: [:edit, :update, :show, :destroy, :microposts]}
  before_action :correct_user_edit, {only: [:edit, :update]}
  before_action :correct_user_destoy, {only: [:destroy]}
  before_action :admin_user, {only: [:index]}
  before_action :admin_destroy, {only: [:destroy]}

  def show
    @store = Store.find_by(id: params[:id])
    @recent_microposts = @user.user_feed.limit(3)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      flash[:danger] = "すでにログインしています。"
      redirect_to @user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @user.image = "/default_icon.jpg"
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = "入力内容をご確認ください。"
      render "/users/new"
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget_remember_digest(@user)
      flash[:success] = "ログインしました。"
      redirect_to user_url(@user)
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "/users/login_form"      
    end
  end

  def logout
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      forget_remember_digest(@user)
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      if params[:user][:user_image]
        @user.user_image.attach(params[:user][:user_image])
      end
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "入力内容を確認してください。"
      render "/users/edit"
    end
  end

  def destroy
    @user.destroy
      if @current_user.admin?
        flash[:success] = "ユーザー情報を削除しました。"
        redirect_to users_path
      else
        forget_remember_digest(@user)
        session[:user_id] = nil
        redirect_to root_path
      end
  end

  def microposts
    @microposts = @user.user_feed.paginate(page: params[:page], per_page: 10)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)    
    end

    def user_info
      @user = User.find(params[:id])
      @user_microposts = @user.user_feed
    end

    def correct_user_edit
      @user = User.find(params[:id])
      unless @user.id == @current_user.id
        flash[:danger] = "無効な処理です。"
        redirect_to @current_user  
      end
    end

    def correct_user_destoy
      @user = User.find(params[:id])
      unless @current_user.admin?
        flash.now[:danger] = "無効な処理です。"
        redirect_to @current_user unless @user.id == @current_user.id
      end
    end

    def admin_destroy
      user = User.find(params[:id])
      if user.admin?
        flash[:danger] = "無効な処理です。"
        redirect_to  @current_user
      end
    end
    
end

