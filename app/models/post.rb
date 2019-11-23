class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validate :picture_size
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "ファイルサイズは5MBまでです")
      end
    end
end
