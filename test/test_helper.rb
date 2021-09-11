ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase

  fixtures :all
  include ApplicationHelper

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def photos_counter(store)
    photo_counter = []
    microposts = store.store_feed
    microposts.each do |micropost|
      if !micropost.micropost_image.empty? && micropost.micropost_image != "no_image.png"
        photo_counter.push(micropost.micropost_image)
      end
    end
    return photo_counter.count
  end
  
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(user, password: '1234Aa', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end

  
end