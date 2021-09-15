require "test_helper"

class LikesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:suzuki)
    @store = stores(:ramen1)
    
  end

  test "likes create test" do
    log_in_as(@user)
    get store_url(@store)
    likes_count = @store.likes.count
    assert_select "input.like"
    assert_select "h3", "登録者数(#{likes_count})"
    assert_difference 'Like.count', 1 do
      post store_like_path(@store), params: {user_id: @user.id, store_id: @store.id} 
    end
    assert_redirected_to store_url(@store)
    follow_redirect!
    assert_select "h3", "登録者数(#{likes_count + 1})"
    assert_select "input.unlike"
    assert_difference 'Like.count', -1 do
      delete store_like_path(@store), params: {user_id: @user.id, store_id: @store.id} 
    end
    assert_redirected_to store_url(@store)
    follow_redirect!
    assert_select "h3", "登録者数(#{likes_count})"
    assert_select "input.like"
  end

end
