class Store < ApplicationRecord
  validates :name, presence: true
  validates :kana, presence: true
  validates :address, presence: true


  def self.search(keyword)
    where(["name like? OR kana like? OR address like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  
end
