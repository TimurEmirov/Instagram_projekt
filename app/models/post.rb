class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likeposts, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                    size:{ less_than: 5.megabytes,
                                    message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [250, 250])
  end
end
