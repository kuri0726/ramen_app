class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_one_attached :store_image
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :store_id, presence: true
  validates :ate_food, presence: true, length: {maximum: 30}
  validates :visit_date, presence: { message: "を選択してください。" }
  validates :visit_time, presence: { message: "を選択してください。" }
  validates :score, presence: { message: "を選択してください。" }
  validates :waiting_time, presence: { message: "を選択してください。" }
  validates :content, presence: true 

end
