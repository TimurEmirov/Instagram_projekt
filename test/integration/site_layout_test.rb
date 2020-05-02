require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # setup do
  #   @user = users(:user_001)
  #   get home_path
  #   sign_in users(:user_001)
  #   post user_session_url
  # end
  #
  # test "layout links" do
  #   get root_path
  #   assert_template 'home/index'
  #   assert_select "a[href=?]", new_user_session_path, count: 0
  #   assert_select "a[href=?]", root_path
  #   assert_select "a[href=?]", user_path(@user)
  #   assert_select "a[href=?]", destroy_user_session_path
  # end
end
