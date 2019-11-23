class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 255 }
end
