class Store < ApplicationRecord

  has_many :microposts, dependent: :destroy
  validates :name, presence: true
  validates :kana, presence: true
  validates :address, presence: true


  def self.search(keyword)
    where(["name like? OR kana like? OR address like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def store_feed
    Micropost.where("store_id = ?" , id)
  end
  
end
