class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def logged_in_user
      store_location
      unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome matey!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile has been updated mate"
      redirect_to @user
    else
      render 'edit'
    end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
       :password_confirmation)
    end
end
end
