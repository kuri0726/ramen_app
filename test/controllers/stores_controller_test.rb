require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)

    @store = stores(:ramen1)
  end

  test "should redirect to login-page when not logged in user access store_path" do
    get store_path(@store)
    assert_redirected_to login_url
  end

  test "should get show" do
    log_in_as(@user)
    get store_path(@store)
    assert_response :success
  end

  test "should redirect to user_path when not admin user access new_sotre_path" do
    log_in_as(@other_user)
    get new_store_path
    assert_redirected_to user_path(@other_user)
  end

  test "should redirect to user_path when not admin user create new store" do
    log_in_as(@other_user)
    assert_no_difference "Store.count" do
      post stores_path, params: { store: { name: "new_ramen01"} }
    end
    assert_redirected_to user_path(@other_user)
  end

  test "not admin user shouldn't get edit_path" do
    log_in_as(@other_user)
    get edit_store_path(@store)
    assert_redirected_to user_path(@other_user)
  end

  test "not admin user shouldn't edit store's information" do
    log_in_as(@other_user)
    patch store_path(@store), params: { store: { name: "new_ramen02"} }
    assert_not flash.empty?
    assert_redirected_to user_path(@other_user)
  end

  test "not admin user shouldn't delete store's information" do
    log_in_as(@other_user)
    delete store_path(@store)
    assert_not flash.empty?
    assert_redirected_to user_path(@other_user)
  end

end
