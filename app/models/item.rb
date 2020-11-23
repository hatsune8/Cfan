class Item < ApplicationRecord

  belongs_to :user
  attachment :image

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length: { in: 1..50 }
  validates :opinion, presence: true, length: { in: 1..200 }
  validates :image, presence: true
  validates :genre, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
