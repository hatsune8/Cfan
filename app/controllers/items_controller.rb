class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:update, :destroy, :edit]

  def index
    @rank = Item.where(id: Favorite.where("created_at >= ?", Date.today).group(:item_id).order('count(item_id) desc').pluck(:item_id))
    @ranks = @rank.sort_by {|x| [x.favorites.count, x.created_at]}.reverse
    @all_ranks = @ranks.first(3)
    # @ranks = @rank.order(created_at: :desc)
    # @all_ranks = @ranks.where("create_at >= ?", Date.today)
    # "create_at >= ?", Date.today/(created_at: :desc)左の二つを付け足すランキングに1日ごとに切り替える使用を追加したい・日付を新しいdesc順にしたい
    # @rank,@ranks,@all_ranksの３つに分けることでランキング・日付リセット・新しい並び順に表示、全てを実現した（この方法は正しいの？=>FP実装完了の目処が立ったらメンターに確認）
    # 下の記述でreturnを使っているのでreturnより下に@ranksの記述をすると、searchの条件分岐によっては通らなくなってしまうのでeachがnilになってメソッドエラーの原因になるので注意
    # ランキング機能参考記事https://qiita.com/mitsumitsu1128/items/18fa5e49a27e727f00b4
    @items = Item.all.order(created_at: :desc)
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

  def correct_user
    @item = Item.find(params[:id])
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end

end
