class HomeController < ApplicationController

  def home
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
    end
  end
end
