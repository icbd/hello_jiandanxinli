module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && hash_authed?(cookies[:remember_token], user.remember_digest)
        log_in user
        @current_user = user
      end
    end

    @current_user || nil
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget current_user
    @current_user = nil
    session.delete(:user_id)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    if user and !user.remember_digest.nil?
      user.forget
    end
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
