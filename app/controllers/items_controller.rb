class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to items_path
  end


private
  def item_params
    params.require(:item).permit(:title, :image, :opinion)
  end

end
