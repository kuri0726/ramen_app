require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)
  end
  
  test "should redirect user_url when invalid email" do
    get login_path
    assert_template "users/login_form"
    post login_path, params: {session: {
                        email: "wanko@example.com",
                        password: "1234Aa" }}
    assert_not flash.empty?
    assert_template "users/login_form"
  end

  test "should redirect user_url when invalid password" do
    get login_path
    assert_template "users/login_form"
    post login_path, params: {session: {
                        email: "yamada@example.com",
                        password: "1234Aaaa" }}
    assert_not flash.empty?
    assert_template "users/login_form"
  end

  test "should log in when valid params" do
    get login_path
    assert_template "users/login_form"
    post login_path, params: {session: {
                        email: "yamada@example.com",
                        password: "1234Aa" }}
    assert_not flash.empty?
    log_in_as(@user)
    @current_user = @user
    assert is_logged_in?
    assert_redirected_to @current_user
    follow_redirect!
    assert_template "users/show"
    assert_equal @user.name, @current_user.name
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    get logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
