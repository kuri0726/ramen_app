class HomeController < ApplicationController

  before_action :logged_in_user_home

  def home
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
    end
  end

  private

    def logged_in_user_home
      if logged_in?
        render "home/home"
      end
    end

end
