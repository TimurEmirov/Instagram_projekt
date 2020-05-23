require 'rails_helper'
RSpec.describe 'Post page', :js, type: :feature do
  let!(:ezio) { create :user }
  let!(:post) { create :post, user: ezio }
  let!(:user) { create :user }


  scenario 'user create post' do
    login_as user

    visit home_path

    within '.post_form' do
      fill_in 'post[content]', with: "Some post"
      attach_file('post[image]', Rails.root.join('spec/fixtures/pixel.png'))
      click_button 'Post'
    end

    expect(page).to have_content("Post created")

    within '.post_form' do
      fill_in 'comment[content]', with: "Some comment"
      click_button 'Post'
    end

    click_button 'Like'

    expect(page).to have_content("1 Like")
    expect(page).to have_content("Some post")
    expect(page).to have_content("Some comment")

    visit user_path(id: ezio.id)
    click_button 'Follow'
    expect(page).to have_button 'Unfollow'
    visit home_path
    expect(page).to have_content("User you follow post it")
  end
end
