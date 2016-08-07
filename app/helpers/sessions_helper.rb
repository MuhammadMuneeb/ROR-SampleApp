module SessionsHelper
  #To login the user
  def log_in(user)
    session[:user_id] = user.id
  end

  #To return the logged in user, if there is any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Returns true if user is logged in, otherwise false
  def logged_in?
    !current_user.nil?
  end
end
