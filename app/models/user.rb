class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, 
                          length: { maximum: 50 }, 
                      uniqueness: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ii
  validates :email, presence: true, 
                      length: {maximum: 255}, 
                      format: {with: VALID_EMAIL_REGEX},
                  uniqueness: {case_sensitive: false}
end
