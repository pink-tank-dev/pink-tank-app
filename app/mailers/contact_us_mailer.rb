class ContactUsMailer < ApplicationMailer
  default to: 'pinktankcollective@gmail.com'
  def send_email(name:, email:, subject:, message:)
    @message = message
    mail(from: "#{name} <#{email}>",
         subject: subject,
         template_path: 'mailers/contact_us_mailer',
         template_name: 'contact_us')
  end
end
