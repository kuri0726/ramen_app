require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:yamada)
    @micropost = @user.microposts.build(content: "So good!!")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "name should be present" do
    @micropost.content = ""
    assert_not @micropost.valid?
  end

end
