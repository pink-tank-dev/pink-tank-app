class ContactUsMailer < ApplicationMailer
  def send_email(name:, email:, subject:, message:)
    @message = message
    mail(reply_to: email_address_with_name(email, name),
         subject: subject,
         template_path: 'mailers/contact_us_mailer',
         template_name: 'contact_us')
  end
end
