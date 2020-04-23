require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get home_index_url
    sign_in users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get help" do
    get home_help_url
    assert_response :success
  end

end
