class UsersController < ApplicationController

  before_action :logged_in_user, {only: [:edit, :update, :show]}

  def show
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "/default_icon.jpg"
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
    @user = User.find(session[:user_id])
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)    
    end

end

