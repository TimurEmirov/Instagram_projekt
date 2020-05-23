require 'rails_helper'
RSpec.describe 'Sign up', :js, type: :feature do

  scenario 'login user' do
    visit new_user_registration_path
    within '.new_user' do
      fill_in 'user[name]', with: "User"
      fill_in 'user[email]', with: "User@copybara.ru"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      attach_file('user[image]', Rails.root.join('spec/fixtures/pixel.png'))
      fill_in 'user[about]', with: "hi"
      click_button 'commit'
    end

    expect(page).to have_content("Post Feed")

  end
end
