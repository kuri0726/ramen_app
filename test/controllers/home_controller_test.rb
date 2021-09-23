require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest 

  def setup
    @base_title = "らぁ麺インフォメーション"
  end

  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

end
