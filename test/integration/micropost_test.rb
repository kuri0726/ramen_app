require "test_helper"

class MicropostIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:yamada)
    @store = stores(:ramen1)
    @micropost_content50 = microposts(:micropost3)
    @micropost_content200 = microposts(:micropost2)
  end
  
  test "microposts for each store are displayed correctly" do
    log_in_as(@admin_user)
    get store_microposts_path(@store)
    assert_template "stores/microposts"
    assert_select "div.pagination"
    @microposts =  Micropost.where(store_id: @store.id).paginate(page: 1)
    @microposts.each do |micropost|
      assert_select "a[href=?]", store_path(@store), text: @store.name, count: 10
    end
    # show additional links if the comment size is 100 or larger 
    assert_select "a[href=?]", micropost_path(@micropost_content50), text: "a * 50", count: 0
    assert_select "a[href=?]", micropost_path(@micropost_content200), text: "続きを読む"
    get micropost_path(@micropost_content200)
    assert_template "microposts/show"
    assert_select "a", text: "投稿を削除する" 
    assert_difference "Micropost.count", -1 do
      delete micropost_path(@micropost_content200)
    end
    assert_not flash.empty?
    assert_redirected_to user_path(@admin_user)
  end

end