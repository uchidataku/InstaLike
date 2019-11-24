class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", 
                                 foreign_key: "follower_id", 
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", 
                                 foreign_key: "followed_id", 
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
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

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  
  def feed
    Post.where("user_id IN (:following_ids) OR user_id = :user_id",
     following_ids: following_ids, user_id: id)
  end
  
  def follow(other_user)
    self.active_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    self.following.include?(other_user)
  end
  
  def like(post)
    self.favorites.create(post_id: post.id)
  end
  
  def unlike(post)
    self.favorites.find_by(post_id: post.id).destroy
  end
  
  def liking?(post)
    self.favorite_posts.include?(post)
  end
  
end
