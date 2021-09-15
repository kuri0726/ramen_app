require "test_helper"

class MicropostCreateTest < ActionDispatch::IntegrationTest

  def setup
    @no_microposts_user = users(:tanaka)

    @store = stores(:ramen1)
  end

  test "valid information should post create" do
    log_in_as(@no_microposts_user)
    get user_path(@no_microposts_user)
    assert_select "div.no-results"
    get microposts_path(@store)
    assert_difference 'Micropost.count', 1 do
      post "/microposts/review/#{@store.id}", params: { micropost: {ate_food: "ramen", visit_date: "2021-09-15", visit_time: "2000-01-01 02:16:00", score: 30, waiting_time: 10, content: "So good!!", store_id: @store.id, user_id: @no_microposts_user.id} }
    end
    micropost = assigns(:micropost)
    assert_not flash.empty?
    assert_redirected_to store_microposts_path(@store)
    get user_path(@no_microposts_user)
    assert_select "div.no-results", count: 0
    assert_select "a","#{micropost.ate_food}"
  end

end
