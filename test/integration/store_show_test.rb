require "test_helper"

class StoreShowTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)
    @normal_user = users(:tanaka)
    @store = stores(:ramen1)
    @microposts = @store.store_feed
  end

  test "stores/show is displayed correctly when admin_user is logged in" do
    log_in_as(@admin_user)
    get store_path(@store)
    assert_template "stores/show"
    assert_equal 54, @microposts.count
    assert_equal 2, photos_counter(@store)
    assert_select "a[href=?]", store_path(@store)
    assert_select "a[href=?]", store_microposts_path
    assert_select "a[href=?]", store_waiting_time_path
    assert_select "a[href=?]", store_photos_path
    assert_select "a[href=?]", microposts_path
    assert_select "a[href=?]", edit_store_path(@store)
    assert_select "a", text: "削除"
    assert_difference "Store.count", -1 do
      delete store_path(@store)
    end
    assert_redirected_to stores_path
  end

  test "stores/show is displayed correctly when normal_user is logged in" do
    log_in_as(@normal_user)
    get store_path(@store)
    assert_template "stores/show"
    assert_equal 54, @microposts.count
    assert_equal 2, photos_counter(@store)
    assert_select "a[href=?]", store_path(@store)
    assert_select "a[href=?]", store_microposts_path
    assert_select "a[href=?]", store_waiting_time_path
    assert_select "a[href=?]", store_photos_path
    assert_select "a[href=?]", microposts_path
    assert_select "a[href=?]", edit_store_path(@store), count: 0
    assert_select "a", text: "削除", count: 0
    assert_no_difference "Store.count" do
      delete store_path(@store)
    end
    assert_redirected_to @normal_user
  end
end
