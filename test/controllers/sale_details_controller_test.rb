require "test_helper"

class SaleDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sale_details_index_url
    assert_response :success
  end
end
