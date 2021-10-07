class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail to: "kuri0726@outlook.jp", subject: '【お問い合わせ】' + @contact.subject
  end
end