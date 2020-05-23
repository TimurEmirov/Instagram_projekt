FactoryBot.define do
  factory :post do
    association :user

    content { FFaker::Lorem.sentence }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.png'))  }

    trait (:with_invalid_image) do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'pixel.txt')) }
    end
  end
end
