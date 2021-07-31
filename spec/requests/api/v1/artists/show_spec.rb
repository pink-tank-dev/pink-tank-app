require 'rails_helper'

RSpec.describe "Api::V1::Artists", type: :request do
  describe "GET /api/v1/artists/:id" do
    let(:artist) { create(:artist) }
    let!(:published_post) { create(:post, :published, artist_id: artist.id) }
    let!(:draft_post) { create(:post, artist_id: artist.id) }

    context "artist exists" do
      before { get "/api/v1/artists/#{artist.id}" }

      it "returns the correct artist" do
        expect(response.status).to eq(200)
        expect(json["id"]).to eq(artist.id)
      end

      it "returns a list of the artist's published posts" do
        expect(response.status).to eq(200)
        expect(json["posts"].size).to eq(1)
      end
    end

    context "artist does not exist" do
      before { get "/api/v1/artists/0"}

      it "returns a 404" do
        expect(response.status).to eq(404)
        expect(json["message"]).to eq("Artist not found")
      end
    end
  end
end
