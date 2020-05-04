class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, length: { maximum: 256 }
  has_one_attached :avatar

  # Returns a resized image for display.
  def display_avatar
    avatar.variant(resize_to_limit: [70, 70])
  end

  def avatar_profile
    avatar.variant(resize_to_limit: [200, 200])
  end

  def feed
    Post.where("user_id = ?", id)
  end
end
