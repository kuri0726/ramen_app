require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
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
    assert_redirected_to user_path(@current_user)
  end

  test "remember me test" do
    log_in_as(@user, remember_me: "1")
    assert_not_empty cookies[:remember_token]
    get logout_path
    assert_empty cookies[:remember_token]
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

end
