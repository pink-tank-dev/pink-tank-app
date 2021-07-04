require "rails_helper"

RSpec.describe ContactUsMailer, type: :mailer do
  it { expect(described_class).to respond_to(:send_email) }

  describe "contact_us" do
    let(:params) do
      {
        name: "Nazrin",
        email: "test@email.com",
        subject: "Test subject",
        message: "Test message"
      }
    end
    let(:mail) { described_class.with(params).send_email }
    let(:to) { ["pinktankcollective@gmail.com"] }

    it { expect(mail.subject).to eq(params[:subject]) }
    it { expect(mail.to).to eq(to) }
    it { expect(mail.from).to eq([params[:email]]) }
    it { expect(mail.body.encoded).to match(params[:message]) }
  end
end
