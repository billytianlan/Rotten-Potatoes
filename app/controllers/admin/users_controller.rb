class Admin::UsersController < ApplicationController

  before_filter :restrict_access, :authorized_user

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def admin?
    current_user && current_user.admin
  end

  def authorized_user
    if !admin?
      flash[:alert] = "You do not have access to that page."
      redirect_to root_path
    end
  end

  def destroy 
    @user = User.find(params[:id])
    if @user.destroy
      UserMailer.delete_email(@user).deliver
    end
    redirect_to admin_users_path
  end


  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def authorized_user
  #   if @current_user.admin == true
  #     flash[:alert] = "You must log in."
  #     redirect_to new_session_path
  #   end
  # end

  # helper_method :current_user


end