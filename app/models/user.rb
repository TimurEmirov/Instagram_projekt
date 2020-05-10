class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likeposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, length: { maximum: 256 }
  has_one_attached :avatar
  after_commit :add_default_avatar, on: [:create, :update]


  # Returns a resized image for display.
  def display_avatar
    avatar.variant(resize_to_limit: [70, 70])
  end

  def avatar_profile
    avatar.variant(resize_to_limit: [250, 250])
  end


  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"

    post_following_like_ids = " SELECT post_id FROM likeposts
                              WHERE user_id IN (#{following_ids})"
    Post.where("user_id IN (#{following_ids}) OR  id IN (#{post_following_like_ids})", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end
  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end

private
def add_default_avatar
  unless avatar.attached?
    self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.png")), filename: 'default.png' , content_type: "image/png")
  end
end
