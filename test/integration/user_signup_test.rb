require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest

  test "should reject when invalid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                        email: "wanko@example.com",
                                        password:              "foo111",
                                        password_confirmation: "A111" } }
    end
    assert_template "users/new"
    assert_select 'div.field_with_errors'
    assert_not flash.empty?
  end

  test "should create acount when valid informaiton" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "aaa",
                                        email: "wanko@prg-8.com",
                                        password:              "fooA111",
                                        password_confirmation: "fooA111" } }
    end
    assert_not flash.empty?
    user = assigns(:user)
    assert_redirected_to user_path(user)
    assert is_logged_in?
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user)
  end
end
