require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get manager" do
    get user_manager_url
    assert_response :success
  end
  test "should get manager" do
    get user_manager_url
    assert_response :success
  end
end
