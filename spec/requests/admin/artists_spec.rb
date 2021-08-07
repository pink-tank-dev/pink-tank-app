require 'rails_helper'

RSpec.describe "Artists", type: :request do
  describe "GET /index" do
    before { get admin_artists_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "GET /new" do
    before { get new_admin_artist_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "POST /create" do
    let(:artist_params) do
      {
        name: Faker::Artist.name,
        about: Faker::Quote.yoda,
        email: Faker::Internet.email,
        statement: Faker::Quotes::Shakespeare.hamlet_quote,
        password: Faker::Internet.password,
        instagram: Faker::Internet.username
      }
    end
    before { post admin_artists_path, params: { artist: artist_params } }
    it { is_expected{ Artist.count }.to change_by(1) }
  end

  describe "GET /edit" do
    let(:artist) { create(:artist) }
    before { get edit_admin_artist_path(artist) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /update" do
    let(:artist) { create(:artist) }
    before { put admin_artist_path(artist), params: { artist: artist_params } }
    let(:artist_params) do
      { name: "Batman" }
    end
    it { expect(artist.reload.name).to eq("Batman") }
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }
    before { get admin_artist_path(artist) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /reset_password" do
    let(:artist) { create(:artist) }
    before { put reset_password_admin_artist_path(artist) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /send_welcome_email" do
    let(:artist) { create(:artist) }
    before { put send_welcome_email_admin_artist_path(artist) }
    it { expect(response).to have_http_status(:success)}
  end
end
