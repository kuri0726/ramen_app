require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)
  end

  test "not logged in user should redirect root_path" do
    get edit_user_path(@user)
    assert_redirected_to login_url
  end

  test "not current user should redirect root_path" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_redirected_to root_path
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params:{user: {
                                name: "sato",
                                email: "sato@example.com",
                                password: "1234Aa",
                                password_confirmation: "1234Aa"} }
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
    follow_redirect!
    @user.reload
    assert_template "users/show"
    assert_equal "sato", @user.name
    assert_equal "sato@example.com", @user.email
  end
end
