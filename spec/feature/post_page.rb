require 'rails_helper'
RSpec.describe 'Post page', :js, type: :feature do
  let!(:user) { create :user }

  scenario 'user create post' do
    login_as user

    visit home_path

    within '.post_form' do
      fill_in 'post[content]', with: "Some thing"

      click_button 'Post'
    end

    expect(page).to have_content("Some thing")

  end
end
