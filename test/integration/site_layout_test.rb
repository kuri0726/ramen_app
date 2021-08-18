require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout kinks" do
    get root_path
    assert_template 'home/home'
    assert_select "a[href=?]", root_path
  end
end
