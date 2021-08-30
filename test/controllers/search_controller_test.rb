require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)

    @store = stores(:ramen1)
  end

  test "should get search" do
    log_in_as(@user)
    get search_path
    assert_response :success
  end
end
