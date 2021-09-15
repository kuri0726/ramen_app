require "test_helper"

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:yamada)
    @no_review_user = users(:tanaka)
    @store = stores(:ramen1)
    @recent_3microposts = @admin_user.user_feed.order(created_at: "DESC").limit(3)
  end

  test "users/show is displayed correctly" do
    log_in_as(@admin_user)
    microposts = @admin_user.user_feed
    get user_path(@admin_user)
    assert_template "users/show"
    assert_select "a[href=?]", edit_user_path(@admin_user)
    assert_select "a[href=?]", user_microposts_path, text: "レビュー(#{microposts.count})"
    assert_select "a", text: "お気に入りのお店(#{@admin_user.likes.count})"
    @recent_3microposts.each do |micropost|
      assert_select "a[href=?]", micropost_path(micropost), text: "#{micropost.ate_food}"
      assert_select "a[href=?]",store_path(micropost.store), text: "#{micropost.store.name}"
      assert_select "a[href=?]",user_path(@admin_user), text: "#{micropost.user.name}"
    end
    assert_select "div.no-results", count: 0
    assert_select "a[href=?]", user_microposts_path, text: "他の投稿も見る"
  end

  test "users/show is displayed correctly when no_review_useris logged in" do
    log_in_as(@no_review_user)
    microposts = @no_review_user.user_feed
    get user_path(@no_review_user)
    assert_template "users/show"
    assert_select "a[href=?]", edit_user_path(@no_review_user)
    # assert_select "a[href=?]", user_microposts_path, text: "レビュー(#{(microposts.count})"
    assert_select "a", text: "お気に入りのお店(#{@no_review_user.likes.count})"
    @recent_3microposts.each do |micropost|
      assert_select "a[href=?]", micropost_path(micropost), text: "#{micropost.ate_food}", count: 0
      assert_select "a[href=?]",store_path(micropost.store), text: "#{micropost.store.name}", count: 0
      assert_select "a[href=?]",user_path(@admin_user), text: "#{micropost.user.name}", count: 0
    end
    assert_select "div.no-results"
    assert_select "a[href=?]", user_microposts_path, text: "他の投稿も見る", count: 0
  end

  test "admin_user enter another user_path" do
    log_in_as(@admin_user)
    get user_path(@no_review_user)
    assert_select "a[href=?]", edit_user_path(@no_review_user), count: 0
    assert_select "a", text: "削除"
  end
  
  test "normal_user enter another user_path" do
    log_in_as(@no_review_user)
    get user_path(@admin_user)
    assert_select "a[href=?]", edit_user_path(@admin_user), count: 0
    assert_select "a", text: "削除", count: 0
  end

end
