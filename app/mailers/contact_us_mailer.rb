class ContactUsMailer < ApplicationMailer
  default to: 'pinktankcollective@gmail.com'
  def contact_us
    @message = params[:message]
    mail(from: sender,
         subject: params[:subject],
         template_path: 'mailers/contact_us_mailer',
         template_name: 'contact_us')
  end

  def sender
    "#{params[:name]} <#{params[:email]}>"
  end
end
