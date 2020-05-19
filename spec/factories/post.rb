FactoryBot.define do
  factory :post do
    association :user

    content { FFaker::Lorem.sentence }
    
    trait (:with_image) do
      image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'pixel.png')) }
    end

    trait (:with_valid_image) do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.png'))  }
    end

    trait (:with_invalid_image) do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'pixel.txt')) }
    end
  end
end
