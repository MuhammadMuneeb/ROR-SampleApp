module SessionsHelper
  #To login the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remember users in persistent mode xD
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Return the user corresponding to the remember token
  def current_user
    if (user_id =  session[:user_id])
     @current_user ||= User.find_by(id: user_id)
   elsif (user_id = cookies.signed[:user_id])
     user = User.find_by(id: user_id)
     if user && user.authenticated?(cookies[:remember_token])
       log_in user
       @current_user
     end
   end
 end

  #To return the logged in user, if there is any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Returns true if user is logged in, otherwise false
  def logged_in?
    !current_user.nil?
  end

  #Forget user
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  #Log out the user!!
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end


  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end


end
