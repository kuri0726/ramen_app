class Like < ApplicationRecord
  belongs_to :user
  belongs_to :store
  validates :user_id, presence: true,  uniqueness: { scope: :store_id }
  validates :store_id, presence: true, uniqueness: { scope: :user_id }
  default_scope -> { order(created_at: :desc) }
  
end
