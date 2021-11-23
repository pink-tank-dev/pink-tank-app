require 'rails_helper'

RSpec.describe "Api::V1::Galleries", type: :request do
  describe "GET api/v1/gallery/artwork" do
    context "when artwork_id not provided" do
      let(:params) { nil }

      before { get "/api/v1/gallery/artwork", params: params }

      it { expect(response.status).to eq(400) }
    end

    context "when artwork_id provided" do
      let(:params) do 
        { artwork_id: artwork.id }
      end

      context "when series with artwork exists" do
        let(:exhibition) { create(:exhibition) }
        let(:artist) { create(:artist) }
        let(:artwork) { create(:artwork, artist: artist) }
        let!(:series) { create(:series, artist: artist, artworks: [artwork], exhibition: exhibition) }

        it do
          get "/api/v1/gallery/artwork", params: params
          expect(response.status).to eq(200)
        end
      end

      context "when series with artwork does not exist" do
        let(:artwork) { double(id: 300) }

        it do
          get "/api/v1/gallery/artwork", params: params
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
