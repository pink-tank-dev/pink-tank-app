# Preview all emails at http://localhost:5000/rails/mailers/contact_us_mailer
class ContactUsMailerPreview < ActionMailer::Preview
  def contact_us
    ContactUsMailer.with(contact_us_params).contact_us
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
