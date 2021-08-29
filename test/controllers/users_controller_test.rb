require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "not current user shouldn't edit" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_redirected_to root_path
  end

  test "not logged in user shouldn't edit" do
    get edit_user_path(@user)
    assert_redirected_to login_url
  end  

  test "not admin user shouldn't get index" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to @other_user
  end

  test "admin user should delete" do 
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test "not admin user shouldn't delete" do 
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
  end

  # test "admin user shouldn't delete admin user" do 
  #   log_in_as(@user)
  #   assert_no_difference 'User.count' do
  #     delete user_path(@user)
  #   end
  # end

end
