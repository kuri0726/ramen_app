require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:yamada)
    @store = stores(:ramen1)
    @micropost = @user.microposts.build(ate_food: "ramen", visit_date: "2021-09-15", visit_time: "2000-01-01 02:16:00", score: 30, waiting_time: 10, content: "So good!!", store_id: @store.id)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "ate_food should be at most 30 characters " do
    @micropost.ate_food = "a" * 31
    assert_not @micropost.valid?
  end

  test "ate_food should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "visit_date should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "visit_time should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "score should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "waiting_time should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
