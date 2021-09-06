require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:yamada)
  end

  test "successful edit" do
    log_in_as(@admin_user)
    get edit_user_path(@admin_user)
    patch user_path(@admin_user), params:{user: {
                                name: "sato",
                                email: "sato@example.com",
                                password: "1234Aa",
                                password_confirmation: "1234Aa"} }
    assert_redirected_to user_path(@admin_user)
    assert_not flash.empty?
    @admin_user.reload
    assert_equal "sato", @admin_user.name
    assert_equal "sato@example.com", @admin_user.email
  end
end
