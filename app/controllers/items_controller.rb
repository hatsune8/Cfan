class ItemsController < ApplicationController

  def index
    @ranks = Item.where(id: Favorite.group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))
    # 下の記述でreturnを使っているのでreturnより下に@ranksの記述をすると、searchの条件分岐によっては通らなくなってしまうのでeachがnilになってメソッドエラーの原因になるので注意
    # ランキング機能参考記事https://qiita.com/mitsumitsu1128/items/18fa5e49a27e727f00b4
    @items = Item.all
    @title = "投稿"
    return @items = @items.order(created_at: :desc) if params[:search].nil?
    @items = Item.where('genre LIKE ?', params[:search]).order(created_at: :desc)
    @title = params[:search]
    # order(created_at: :desc)をつけることで投稿日時が新しいものが上に表示されるようになっているhttp://ihatov08.hatenablog.com/entry/2016/02/26/111447

  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to items_path
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end


private
  def item_params
    params.require(:item).permit(:title, :image, :opinion, :genre)
  end

end
