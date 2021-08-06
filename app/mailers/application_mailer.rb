class ApplicationMailer < ActionMailer::Base
  default from: 'pinktankdev@gmail.com'
  default to: 'pinktankcollective@gmail.com'
  layout 'mailer'
end
