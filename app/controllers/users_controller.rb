class UsersController < ApplicationController

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items.page(params[:page]).reverse_order.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def favo
    @user = current_user
    @favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end
