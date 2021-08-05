require 'rails_helper'

RSpec.describe "Api::ContactUs", type: :request do
  describe "POST /create" do
    let(:params) do
      {
        contact_u: {
          name: "Test",
          email: "test@email.com",
          subject: "Test subject",
          message: "Test message"
        }
      }
    end
    before { post "/api/v1/contact_us", params: params }

    it { expect(response.status).to eq(204) }
  end
end
