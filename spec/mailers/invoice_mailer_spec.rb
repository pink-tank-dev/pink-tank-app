require 'rails_helper'

RSpec.describe InvoiceMailer, type: :mailer do
  let(:artist) { create(:artist) }
  let(:artwork) { create(:artwork, artist: artist) }

  describe 'send_to_admin' do
  end

  describe 'send_to_acquirer' do
  end
end
