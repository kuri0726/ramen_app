require "test_helper"

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = Store.new(name: "Ramen01")
  end

  test "should be valid" do
    assert @store.valid?
  end

  test "name should be present" do
    @store.name = ""
    assert_not @store.valid?
  end
end
