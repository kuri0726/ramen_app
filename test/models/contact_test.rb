require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @contact = Contact.new(name: "Example", email: "contact@example.com",
                    subject: "foobarA1", message: "お店の追加をお願いいたします。")
  end

  test "should be valid" do
    assert @contact.valid?
  end

  test "name should be present" do
    @contact.name = "     "
    assert_not @contact.valid?
  end

  test "email should be present" do
    @contact.email = "     "
    assert_not @contact.valid?
  end

  test "subject should be present" do
    @contact.subject = "     "
    assert_not @contact.valid?
  end

  test "message should be present" do
    @contact.message = "     "
    assert_not @contact.valid?
  end

  test "name should not be too long" do
    @contact.name = "a" * 13
    assert_not @contact.valid?
  end

  test "email should not be too long" do
    @contact.email = "a" * 250 + "@example.com"
    assert_not @contact.valid?
  end

end
