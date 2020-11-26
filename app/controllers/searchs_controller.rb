class SearchsController < ApplicationController

  def search
    @rank = Item.where(id: Favorite.where("created_at >= ?", Date.today).group(:item_id).order('count(item_id) desc').pluck(:item_id))
    @ranks = @rank.sort_by {|x| [x.favorites.count, x.created_at]}.reverse
    @all_ranks = @ranks.first(3)

    @word = params["search"]["word"]
    @model = params["search"]["model"]
    @match = params["search"]["match"]
    if @model == 1.to_s
      if @match == 1.to_s
        @users = User.where('name LIKE ?', @word).order(created_at: :desc)
      else
        @users = User.where('name LIKE ?', '%'+@word+'%').order(created_at: :desc)
      end
    end
    if @model == 2.to_s
      if @match == 1.to_s
        @items = Item.where('title LIKE ?', @word).order(created_at: :desc)
      else
        @items = Item.where('title LIKE ?', '%'+@word+'%').order(created_at: :desc)
      end
    end
  end
end
