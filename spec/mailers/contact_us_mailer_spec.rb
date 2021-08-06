require "rails_helper"

RSpec.describe ContactUsMailer, type: :mailer do
  describe "send_email" do
    let(:name) { "Test" }
    let(:email) { "test@email.com" }
    let(:subject) { "Test subject" }
    let(:message) { "Test message" }
    let(:mail) do
      described_class.send_email(name: name,
                                 email: email,
                                 subject: subject,
                                 message: message)
    end
    let(:to) { ["pinktankcollective@gmail.com"] }

    it { expect(mail.subject).to eq(subject) }
    it { expect(mail.to).to eq(to) }
    it { expect(mail.reply_to).to eq([email]) }
    it { expect(mail.body.encoded).to match(message) }
  end
end
