require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @adminuser = users(:yamada)
    @other_user = users(:tanaka)
  end

  test "not logged in user's header layout" do
    get root_path
    assert_template 'home/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@adminuser), count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", stores_path, count: 0
    assert_select "a[href=?]", new_store_path, count: 0
    assert_select "a[href=?]", "/search", count: 1
    assert_select "a", text: "退会する　", count: 0
  end

  test "logged in user's header layout" do
    log_in_as(@other_user)
    get root_path
    assert_template 'home/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@other_user)
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", stores_path, count: 0
    assert_select "a[href=?]", new_store_path, count: 0
    assert_select "a[href=?]", "/search", count: 2
    assert_select "a", text: "退会する　", count: 1
  end

  test "admin user's header layout" do
    log_in_as(@adminuser)
    get root_path
    assert_template 'home/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@adminuser)
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", stores_path
    assert_select "a[href=?]", new_store_path
    assert_select "a[href=?]", "/search", count: 2
    assert_select "a", text: "退会する　", count: 0
  end

end
