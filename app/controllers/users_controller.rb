class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @mysteries = @user.mysteries.page(params[:page]).per(9)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    user = User.find(params[:id])
    user.update(is_deleted:true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email,:name,:introduction,:image,:is_deleted)
  end

end
