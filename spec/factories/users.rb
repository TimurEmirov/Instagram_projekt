FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    about { FFaker::Job.title }
    password { 'password' }
    password_confirmation { 'password' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'pixel.png'))}
  end
end
