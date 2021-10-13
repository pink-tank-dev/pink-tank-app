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
    
    before { post admin_artists_path, params: artist_params }

    

    context "valid params" do
      let(:artist_params) do
        {
          artist: {
            name: Faker::Artist.name,
            about: Faker::Quote.yoda,
            email: Faker::Internet.email,
            statement: Faker::Quotes::Shakespeare.hamlet_quote,
            password: Faker::Internet.password,
            instagram: Faker::Internet.username,
            status: :active
          }
        }
      end

      it { expect(Artist.last.name).to eq(artist_params[:artist][:name]) }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "invalid params" do
      let(:artist_params) do
        {
          artist: {
            name: nil,
            about: Faker::Quote.yoda,
            email: Faker::Internet.email,
            statement: Faker::Quotes::Shakespeare.hamlet_quote,
            password: Faker::Internet.password,
            instagram: Faker::Internet.username,
            status: :active
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /edit" do
    before { get edit_admin_artist_path(artist.friendly_id) }

    context "artist exists" do
      let(:artist) { create(:artist) }

      it { expect(response.status).to eq(200) }
    end

    context "artist does not exist" do
      let(:artist) { double(friendly_id: "noexist") }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT /update" do
    let(:artist) { create(:artist) }
    before { put admin_artist_path(artist.friendly_id), params: artist_params }
    

    context "valid params" do
      let(:artist_params) do
        {
          artist: {
            name: "Batman"
          }
        }
      end

      it { expect(artist.reload.name).to eq("Batman") }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "invalid params" do
      let(:artist_params) do
        {
          artist: {
            name: nil
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /show" do
    before { get admin_artist_path(artist.friendly_id) }

    context "artist exists" do
      let(:artist) { create(:artist) }

      it { expect(response.status).to eq(200) }
    end

    context "artist does not exist" do
      let(:artist) { double(friendly_id: "noexist") }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT /reset_password" do
    let(:artist) { create(:artist) }
    before { put reset_password_admin_artist_path(artist.friendly_id) }

    it { expect(response.status).to eq(204) }
  end

  describe "PUT /send_welcome_email" do
    let(:artist) { create(:artist) }
    before { put send_welcome_email_admin_artist_path(artist.friendly_id) }

    it { expect(response.status).to eq(204) }
  end
end
