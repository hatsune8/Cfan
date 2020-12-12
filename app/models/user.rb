class User < ApplicationRecord
  after_initialize :set_default, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, uniqueness: true



  private
  def set_default
    self.introduction ||= "introductionが未入力です"
  end

end
