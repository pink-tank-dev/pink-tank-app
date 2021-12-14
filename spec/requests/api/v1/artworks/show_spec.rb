require 'rails_helper'

RSpec.describe "Api::V1::Galleries::Artworks#show", type: :request do
  describe "GET api/v1/gallery/artworks/:id" do
    context "when artwork exists" do
      let(:exhibition) { create(:exhibition) }
      let(:artist) { create(:artist) }
      let(:artwork) { create(:artwork, artist: artist) }
      let!(:series) { create(:series, artist: artist, artworks: [artwork], exhibition: exhibition) }

      before { get "/api/v1/gallery/artworks/#{artwork.id}" }

      it { expect(response.status).to eq(200) }
    end

    context "when artwork does not exist" do
      let(:artwork) { double(id: 300) }

      before { get "/api/v1/gallery/artworks/#{artwork.id}" }

      it { expect(response.status).to eq(404) }
    end
  end
end
