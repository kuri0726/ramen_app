require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @other_user = users(:tanaka)
    @store = stores(:ramen1)
    @micropost = microposts(:micropost1)
  end

  test "not logged in user shouldn't get review" do
    get "/microposts/review/#{@store.id}"
    assert_response :redirect
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get review" do
    log_in_as(@user)
    get "/microposts/review/#{@store.id}"
    assert_response :success
  end

  test "should  when user send invalid date" do
    log_in_as(@user)
    get microposts_path(@store)
    assert_no_difference "Micropost.count" do
      post "/microposts/review/#{@store.id}", params: { micropost: {ate_food: "", visit_date: "2000-01-01", visit_time: "2000-01-01 02:16:00", score: 30, waiting_time: 10, content: "So good!!", store_id: @store.id, user_id: @user.id, week: ""} }
    end
    assert_not flash.empty?
  end

  test "other user shouldn't delete wrong microposts" do
    log_in_as(@other_user)
    get micropost_path(@micropost)
    assert_select "a", text: "投稿を削除する" ,count: 0
    assert_no_difference "Micropost.count" do
      delete micropost_path(@micropost)
    end
    assert_not flash.empty?
    assert_redirected_to user_path(@other_user)
  end

end
