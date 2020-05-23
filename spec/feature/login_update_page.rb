require 'rails_helper'
RSpec.describe 'Sign in', :js, type: :feature do
  let!(:user) { create :user }

  scenario 'login and update user' do
    visit new_user_session_path
    within '.new_user' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'commit'
    end

    visit user_path(id: user.id)
    expect(page).to have_content(user.name)

    visit edit_user_registration_path
    within '.edit_user' do
      fill_in 'user[name]', with: "Ezio"
      fill_in 'user[email]', with: "Ezio200@gmail.com"
      fill_in 'user[current_password]', with: user.password
      click_button 'commit'
    end
    visit user_path(id: user.id)
    expect(page).to have_content("Ezio")
    expect(page).to have_content("ezio200@gmail.com")
  end
end
