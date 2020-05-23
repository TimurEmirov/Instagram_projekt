class Post < ApplicationRecord
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  has_many :comments, dependent: :destroy
  has_many :likeposts, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 512}
  validates :image, presence: true
  after_commit :resize_image, on: [:create]

  def display_image_small
    image_url(:medium)
  end

  def display_image_large
    image_url(:large)
  end

  private
    def resize_image
      # unless self.image
      #   image { Rack::Test::UploadedFile.new(Rails.root.join("app", "assets", "images", "default.png"))}
        #self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.png")), filename: 'default.png' , content_type: "image/png")
        image_derivatives!
      # end
    end


end
