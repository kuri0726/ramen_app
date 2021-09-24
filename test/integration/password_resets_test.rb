require "test_helper"

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:yamada)
  end

  test "password_reset test" do
    get new_password_reset_path
    assert_template "password_resets/new"
    post password_resets_path, params:{ password_reset: 
                                      { email: ""}}
    assert_not flash.empty?
    post password_resets_path, params:{ password_reset: 
                                      { email: @user.email}}
    assert_redirected_to sent_path
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: "")
    assert_not flash.empty?
    assert_redirected_to new_password_reset_url
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template "password_resets/edit"
    patch password_reset_path(user.reset_token), params:{ 
                                      email: user.email,
                                      user: 
                                    { password: "",
                                      password_confirmation: ""}}
    assert_not flash.empty?
    patch password_reset_path(user.reset_token), params:{ 
                                      email: user.email,
                                      user:
                                    { password: "1111",
                                      password_confirmation: "1111"}}
    assert_not flash.empty?
    patch password_reset_path(user.reset_token), params:{ 
                                      email: user.email,
                                      user:
                                    { password: "1111Aa",
                                      password_confirmation: "1111Bb"}}
    assert_not flash.empty?
    patch password_reset_path(user.reset_token), params:{ 
                                      email: user.email,
                                      user:
                                    { password: "1111Aa",
                                      password_confirmation: "1111Aa"}}
    assert_not flash.empty?
    assert_redirected_to user
  end
end
