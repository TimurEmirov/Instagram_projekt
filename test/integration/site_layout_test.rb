require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  setup do
    get home_path
    sign_in users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "layout links" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
  end
end
