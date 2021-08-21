class UsersController < ApplicationController

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
      session[:user_id] = @user.id
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
      session[:user_id] = @user.id
      flash[:success] = "ログインしました。"
      redirect_to user_url(@user)
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています。"
      render "/users/login_form"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def edit
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

