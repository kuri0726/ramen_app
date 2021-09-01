require "test_helper"

class StoreCreateTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)
  end

  test "should reject when invalid information" do
    log_in_as(@admin_user)
    get new_store_path
    assert_no_difference 'Store.count' do
      post stores_path, params: { store: { name:  ""} }
    end
    assert_template "stores/new"
    assert_select 'div.field_with_errors'
    assert_not flash.empty?
  end

  test "should create acount when valid informaiton" do
    log_in_as(@admin_user)
    get new_store_path
    assert_difference 'Store.count', 1 do
      post stores_path, params: { store: { name:  "aaa" ,
                                          kana: "あああ",
                                          address: "日本"} }
    end
    assert_not flash.empty?
    store = assigns(:store)
    assert_redirected_to store_path(store)
  end
end
