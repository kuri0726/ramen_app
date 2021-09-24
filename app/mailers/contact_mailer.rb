class ContactMailer < ApplicationMailer
  def send_mail(contact)
    user = User.first
    @contact = contact
    mail to:  user.email, subject: '【お問い合わせ】' + @contact.subject
  end
end
