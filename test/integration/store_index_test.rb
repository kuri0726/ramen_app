require "test_helper"

class StoreIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)

    @store = stores(:ramen1)
  end

  test "index page" do
    log_in_as(@admin_user)
    get stores_path
    assert_template "stores/index"
    assert_select "div.pagination"
    first_page_of_stores = Store.paginate(page: 1)
    first_page_of_stores.each do |store|
      assert_select "a[href=?]", store_path(store), text: store.name
    end
    assert_difference "Store.count", -1 do
      delete store_path(@store)
    end
  end
end
