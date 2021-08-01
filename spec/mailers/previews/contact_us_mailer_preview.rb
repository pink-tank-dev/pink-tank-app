# Preview all emails at http://localhost:5000/rails/mailers/contact_us_mailer
class ContactUsMailerPreview < ActionMailer::Preview
  def send_email
    ContactUsMailer.with(contact_us_params).send_email
  end

  private

  def contact_us_params
    {
      "name": "Test",
      "email": "test@mail.com",
      "subject": "Test subject",
      "message": "Test message"
    }
  end
end
