require 'rails_helper'

RSpec.describe "Api::V1::Galleries", type: :request do
  describe "GET /api/v1/gallery" do
    let(:exhibition) { create(:exhibition) }
    let(:artist_1) { create(:artist, name: 'Shawn') }
    let(:artist_2) { create(:artist, name: 'Becca') }
    let(:artwork_1) { create(:artwork, artist: artist_1) }
    let(:artwork_2) { create(:artwork, artist: artist_2) }
    let!(:series_1) { create(:series, artist: artist_1, artworks: [artwork_1], exhibition: exhibition) }
    let!(:series_2) { create(:series, artist: artist_2, artworks: [artwork_2], exhibition: exhibition) }

    before { get "/api/v1/gallery" }

    it do
      expect(response.status).to eq(200)
      expect(json["exhibition"]["series"].map { |series| series["artist_name"] }).to eq(['Becca', 'Shawn'])
    end
  end
end
