require "test_helper"

class ContactsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "contact test" do
    get new_contact_path
    assert_template "contacts/new"
    assert_difference 'Contact.count', 1 do
      post contacts_path, params: { contact: { name:  "Example User",
                                        email: "user@example.com",
                                        subject: "お願い",
                                        message: "ログインできません。" } }
    end                                    
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to done_path
    follow_redirect!
    assert_template "contacts/done"
  end
end
