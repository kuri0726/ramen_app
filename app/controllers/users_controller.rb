class UsersController < ApplicationController

  before_action :logged_in_user, {only: [:edit, :update, :show]}
  before_action :corrent_user, {only: [:edit, :update]}

  def show
    @user = User.find(session[:user_id])
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
    @user.image_name = "default_icon.jpg"
    if @user.save
      flash[:success] = "新規登録が完了しました。"
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
    if params[:user][:user_image]
      @user.user_image.attach(params[:user][:user_image])
      # @user.image_name = "#{@user.id}.jpg"
      # image = params[:user][:user_image]
      # File.binwrite("public/images/#{@user.image_name}", image.read)
    end
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "入力内容を確認してください。"
      render "/users/edit"
    end
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name)    
    end

    def corrent_user
      @user = User.find(params[:id])
      redirect_to root_path  unless @user.id == @current_user.id
    end

end

