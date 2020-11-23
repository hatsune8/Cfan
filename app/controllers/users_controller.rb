class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:update, :destroy, :edit]

  def index
    @user = current_user
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

  def withdrawal
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    user = current_user
    if user.destroy
      redirect_to root_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path
    end
  end


end
