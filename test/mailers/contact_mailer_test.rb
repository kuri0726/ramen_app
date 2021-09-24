require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  
  test "contact_mailer" do
    contact = Contact.first
    mail = ContactMailer.send_mail(contact)
    # assert_equal [ENV["TOMAIL"]], mail.to
    assert_equal ["ramen_app@example.com"], mail.from
    assert_equal "【お問い合わせ】店舗を追加したいです。", mail.subject
    assert_match "YamadaTaro 様 から問い合わせがありました。", mail.body.encoded
  end

end
