require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get home_path
    sign_in users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get home_path
    assert_response :success
  end

  test "should get help" do
    get help_path
    assert_response :success
  end

end
