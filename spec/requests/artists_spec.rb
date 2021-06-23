require 'rails_helper'

RSpec.describe "Artists", type: :request do
  describe "GET /index" do
    before { get artists_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "GET /new" do
    before { get new_artist_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "POST /create" do
    before { post artists_path, params: { artist: artist_params } }
    let(:artist_params) do
      {
        name: Faker::Name.name,
        about: Faker::Quote.yoda
      }
    it { is_expected{ Artist.count }.to change_by(1) }
    end
  end

  describe "GET /edit" do
    let(:artist) { create(:artist) }
    before { get edit_artist_path(artist) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /update" do
    let(:artist) { create(:artist) }
    before { put artist_path(artist), params: { artist: artist_params } }
    let(:artist_params) do
      { name: "Batman" }
    end
    it { expect(artist.reload.name).to eq("Batman") }
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }
    before { get artist_path(artist) }
    it { expect(response).to have_http_status(:success) }
  end
end
