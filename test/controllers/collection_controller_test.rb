require "test_helper"

class CollectionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get collection_new_url
    assert_response :success
  end
end
