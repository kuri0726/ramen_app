module UsersHelper

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def log_in(user)
    session[:user_id] = user.id
    @current_user = User.find_by(id: session[:user_id])
  end

  def forget_remember_digest(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # def like_store(user, stote)
  #   if like = Like(user_id: user.id, store_id: store.id)

  #   else
  #     return false
  #   end
  # end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

end
