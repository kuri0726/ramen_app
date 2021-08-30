require "test_helper"

class UserIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)
    @other_user = users(:tanaka)
  end

  test "index page" do
    log_in_as(@admin_user)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination"
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select "img"
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user.admin?
        assert_select "a[href=?]", user_path(user), text: "削除"
      end
    end
    assert_difference "User.count", -1 do
      delete user_path(@other_user)
    end
  end
end
