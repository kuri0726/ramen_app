require "test_helper"

class StoreEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)

    @store = stores(:ramen1)
  end

  test "successful edit" do
    log_in_as(@admin_user)
    get edit_store_path(@store)
    patch store_path(@store), params:{store: {
                                name: "edit-ramen"} }
    assert_redirected_to store_path(@store)
    assert_not flash.empty?
    follow_redirect!
    @store.reload
    assert_template "stores/show"
    assert_equal "edit-ramen", @store.name
  end
end
