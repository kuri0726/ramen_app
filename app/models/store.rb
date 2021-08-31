class Store < ApplicationRecord
  validates :name, presence: true

  def self.search(keyword)
    where(["name like? OR kana like? OR address like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  
end
