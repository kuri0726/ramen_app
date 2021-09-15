require "test_helper"

class LikeTest < ActiveSupport::TestCase

  def setup
    @user = users(:yamada)
    @store = stores(:store_3)
    @registered_store = stores(:ramen1)
    @like = Like.new(user_id: @user.id, store_id: @store.id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "user_id should be present" do
    @like.user_id = "     "
    assert_not @like.valid?
  end

  test "store_id should be present" do
    @like.store_id = "     "
    assert_not @like.valid?
  end

  test "should be uniqueness" do
    @like = Like.new(user_id: @user.id, store_id: @registered_store.id)
    assert_not @like.valid?
  end

  test "order should be most recent first" do
    assert_equal likes(:most_recent), Like.first
  end

end
