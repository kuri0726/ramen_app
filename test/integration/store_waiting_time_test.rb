require "test_helper"

class WaitingTimeTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:yamada)
    @store = stores(:ramen1)
  end

  test "waitinge_time test" do
    log_in_as(@user)
    get store_waiting_time_path(@store)
    assert_template "stores/waiting_time"
    get store_waiting_time_path(@store), params: {time: "", week: ""}
    assert_select "h2", "待ち時間: レビューなし"
    assert_select "h2", "時間帯: 未選択"
    assert_select "h2", "曜日: 未選択"
    assert_select "div.index-form", count: 0
    assert_select "div.micropost-top",count: 0
    get store_waiting_time_path(@store), params: {time: "2000-01-01 10:00:00 UTC" , week: "1"}
    avg_waiting_time(@store, 10, "1")
    assert_select "h2", "待ち時間: 推定 #{@waiting_time}分"
    assert_select "h2", "時間帯: 10時台"
    assert_select "h2", "曜日: 土日"
    assert_select "div.index-form"
    assert_select "div.micropost-top", count: @microposts.count
    get store_waiting_time_path(@store), params: {time: "" , week: "0"}
    avg_waiting_time(@store, "", "0")
    assert_select "h2", "待ち時間: 推定 #{@waiting_time}分"
    assert_select "h2", "時間帯: 未選択"
    assert_select "h2", "曜日: 平日"
    assert_select "div.index-form"
    # assert_select "div.micropost-top", count: @microposts.count
  end

end
