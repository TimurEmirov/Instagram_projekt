class Post < ApplicationRecord
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  has_many :comments, dependent: :destroy
  has_many :likeposts, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 512}

  def display_image_small
    image_derivatives!
    image_url(:medium)
  end

  def display_image_large
    image_derivatives!
    image_url(:large)
  end

  
end
