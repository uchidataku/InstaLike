class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, 
                          length: { maximum: 50 }, 
                      uniqueness: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ii
  validates :email, presence: true, 
                      length: {maximum: 255}, 
                      format: {with: VALID_EMAIL_REGEX},
                  uniqueness: {case_sensitive: false}
                  
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        user_name: auth.info.name,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
    
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
    
    def feed
      Posts.where("user_id = ?", id)
    end
end
