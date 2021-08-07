require "rails_helper"

RSpec.describe ArtistsMailer, type: :mailer do
  let(:artist) { create(:artist) }
  let(:temporary_password) { SecureRandom.hex(10) }
  describe "send_welcome_email" do
    let(:mail) do
      described_class.with(artist_id: artist.id).send_welcome_email(temporary_password: temporary_password)
    end

    it { expect(mail.subject).to eq('Welcome to Pink Tank!') }
    it { expect(mail.to).to eq([artist.email]) }
  end

  describe "send_reset_password_email" do
    let(:mail) do
      described_class.with(artist_id: artist.id).send_reset_password_email(temporary_password: temporary_password)
    end

    it { expect(mail.subject).to eq('Pssst! Pink Tank here with your reset password.') }
    it { expect(mail.to).to eq([artist.email]) }
  end
end
