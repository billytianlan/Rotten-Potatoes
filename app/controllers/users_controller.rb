class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id #auto login
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy 
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_path
  end

  protected

  def user_params
    params.require(:user).permit(
      :email, 
      :firstname, 
      :lastname, 
      :password, 
      :password_confirmation
    )
  end

end

