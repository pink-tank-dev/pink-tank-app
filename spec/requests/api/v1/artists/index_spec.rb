require 'rails_helper'

RSpec.describe "Api::V1::Artists", type: :request do
  describe "GET /api/v1/artists" do
    let!(:artists) { create_list(:artist, 2) }

    before { get "/api/v1/artists" }

    it "returns a list of artists" do
      expect(response.status).to eq(200)
      expect(json["artists"].size).to eq(2)
    end
  end
end
