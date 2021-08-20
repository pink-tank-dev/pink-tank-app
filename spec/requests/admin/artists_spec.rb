require 'rails_helper'

RSpec.describe "Artists", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /index" do
    before { get admin_artists_path }

    it { expect(response.status).to eq(200) }
  end

  describe "GET /new" do
    before { get new_admin_artist_path }

    it { expect(response.status).to eq(200) }
  end

  describe "POST /create" do
    let(:artist_params) do
      {
        name: Faker::Artist.name,
        about: Faker::Quote.yoda,
        email: Faker::Internet.email,
        statement: Faker::Quotes::Shakespeare.hamlet_quote,
        password: Faker::Internet.password,
        instagram: Faker::Internet.username,
        status: :active
      }
    end
    before { post admin_artists_path, params: { artist: artist_params } }

    it { expect(Artist.last.name).to eq(artist_params[:name]) }
  end

  describe "GET /edit" do
    let(:artist) { create(:artist) }
    before { get edit_admin_artist_path(artist.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update" do
    let(:artist) { create(:artist) }
    before { put admin_artist_path(artist.id), params: { artist: { name: "Batman" } } }
    
    it { expect(artist.reload.name).to eq("Batman") }
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }
    before { get admin_artist_path(artist.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /reset_password" do
    let(:artist) { create(:artist) }
    before { put reset_password_admin_artist_path(artist.id) }

    it { expect(response.status).to eq(204) }
  end

  describe "PUT /send_welcome_email" do
    let(:artist) { create(:artist) }
    before { put send_welcome_email_admin_artist_path(artist.id) }

    it { expect(response.status).to eq(204) }
  end
end
