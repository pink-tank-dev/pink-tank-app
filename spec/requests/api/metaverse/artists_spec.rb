require 'rails_helper'

RSpec.describe "Api::Metaverse::Artists", type: :request do
  describe "GET /show" do
    let(:artist) { create(:artist) }
    let(:exhibition) { create(:exhibition) }
    let(:artwork_1) { create(:artwork, artist: artist) }
    let(:artwork_2) { create(:artwork, artist: artist, position: 2) }
    let!(:series) { create(:series, artist: artist, exhibition: exhibition, artworks: [artwork_1, artwork_2]) }
    
    context "artist exists" do
      before { get "/api/metaverse/artists/#{artist.id}" }

      it "returns the correct artist" do
        expect(response.status).to eq(200)
        expect(json["id"]).to eq(artist.id)
      end

      it "returns the series and the list of artworks" do
        expect(response.status).to eq(200)
        expect(json["series"]["id"]).to eq(series.id)
        expect(json["series"]["artworks"].size).to eq(2)
      end
    end

    context "artist does not exist" do
      before { get "/api/metaverse/artists/0" }

      it "returns a 404" do
        expect(response.status).to eq(404)
        expect(json["message"]).to eq("Artist not found")
      end
    end
  end
end
