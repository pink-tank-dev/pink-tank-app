class ContactUsMailer < ApplicationMailer
  default template_path: 'mailers/contact_us_mailer'

  def send_email(name:, email:, subject:, message:)
    @message = message
    mail(reply_to: email_address_with_name(email, name),
         subject: subject,
         template_name: 'email')
  end
end
