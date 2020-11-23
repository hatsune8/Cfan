class SearchsController < ApplicationController
  def search
    @ranks = Item.where(id: Favorite.group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))
    # @ranks = @rank.order(created_at: :desc)
    @all_ranks = @ranks.where("create_at >= ?", Date.today)
    
    @word = params["search"]["word"]
    @model = params["search"]["model"]
    @match = params["search"]["match"]
    if @model == 1.to_s
      if @match == 1.to_s
        @users = User.where('name LIKE ?', @word)
      else
        @users = User.where('name LIKE ?', '%'+@word+'%')
      end
    end
    if @model == 2.to_s
      if @match == 1.to_s
        @items = Item.where('title LIKE ?', @word)
      else
        @items = Item.where('title LIKE ?', '%'+@word+'%')
      end
    end
  end
end
