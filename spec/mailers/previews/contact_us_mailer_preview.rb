# Preview all emails at http://localhost:5000/rails/mailers/contact_us_mailer
class ContactUsMailerPreview < ActionMailer::Preview
  def send_email
    ContactUsMailer.send_email(name: "Test",
                               email: "test@mail.com",
                               subject: "Test subject",
                               message: "Test message")
  end
end
