require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user = users(:yamada)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "パスワードリセット", mail.subject
    assert_equal ["yamada@example.com"], mail.to
    assert_equal ["ramen_app@example.com"], mail.from
    # assert_match user.reset_token,        mail.body.encoded
    # assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
