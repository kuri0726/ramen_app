require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @store = stores(:ramen1)
  end

  test "not logged in user shouldn't get review" do
    get "/microposts/review/#{@store.id}"
    assert_response :redirect
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get review" do
    log_in_as(@user)
    get "/microposts/review/#{@store.id}"
    assert_response :success
  end

end
