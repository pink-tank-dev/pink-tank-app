class ContactUsMailer < ApplicationMailer
  default to: 'pinktankcollective@gmail.com'
  def send_email
    @message = params[:message]
    mail(from: "#{params[:name]} <#{params[:email]}>",
         subject: params[:subject],
         template_path: 'mailers/contact_us_mailer',
         template_name: 'contact_us')
  end
end
