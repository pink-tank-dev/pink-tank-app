require 'rails_helper'

RSpec.describe "Artworks", type: :request do
  let!(:current_user) { create(:user) }
  let!(:artist) { create(:artist) }

  before { login_user(current_user) }

  shared_examples "successful response" do
    it { expect(response.status).to eq(200) }
  end

  shared_examples "successful redirect and response" do
    it "redirects" do
      expect(response.status).to eq(302)

      follow_redirect!
      expect(response.status).to eq(200)
    end
  end

  describe "GET /new" do
    context "artist exists" do
      before { get new_admin_artist_artwork_path(artist_id: artist.friendly_id) }

      it_behaves_like "successful response"
    end

    context "artist does not exist" do
      let(:artist) { double(friendly_id: 300) }

      before { get new_admin_artist_artwork_path(artist_id: artist.friendly_id) }

      it_behaves_like "successful redirect and response"
    end
  end

  describe "POST /create" do
    before { post admin_artist_artworks_path(artist_id: artist.friendly_id), params: artwork_params }

    context "valid params" do
      let(:artwork_params) do
        {
          artwork: {
            file: Rack::Test::UploadedFile.new('spec/fixtures/dummy.jpg', 'image/jpeg'),
            title: Faker::Book.title,
            description: Faker::Movies::BackToTheFuture.quote,
            medium: Faker::Color.color_name,
            measurements: Faker::Measurement.height,
            status: :available
          }
        }
      end

      it_behaves_like "successful redirect and response"

      it "creates artwork belonging to the artist" do
        artist.reload
        expect(artist.artworks.first.id).to eq(Artwork.last.id)
      end
    end

    context "invalid params" do
      let(:artwork_params) do
        {
          artwork: {
            title: Faker::Book.title,
            description: Faker::Movies::BackToTheFuture.quote,
            measurements: Faker::Measurement.height
          }
        }
      end

      it_behaves_like "successful response"
    end
  end

  describe "GET /edit" do
    before { get edit_admin_artist_artwork_path(artist_id: artist.friendly_id, id: artwork.id) }

    context "artwork exists" do
      let!(:artwork) { create(:artwork) }

      context "artist exists" do
        it_behaves_like "successful response"
      end
  
      context "artist does not exist" do
        let(:artist) { double(friendly_id: 300) }
  
        it_behaves_like "successful redirect and response"
      end
    end

    context "artwork does not exist" do
      let!(:artwork) { double(id: 300) }

      context "artist exists" do
        it_behaves_like "successful redirect and response"
      end
  
      context "artist does not exist" do
        let(:artist) { double(friendly_id: 300) }
  
        it_behaves_like "successful redirect and response"
      end
    end
  end

  describe "PUT /update" do
    let!(:artwork) { create(:artwork, artist: artist) }

    before do
      put admin_artist_artwork_path(artist_id: artist.friendly_id, id: artwork.id), params: artwork_params
    end

    context "valid params" do
      let(:artwork_params) do
        {
          artwork: {
            description: Faker::Movies::BackToTheFuture.quote
          }
        }
      end

      it_behaves_like "successful redirect and response"

      it "successfully updates the artwork data" do
        artwork.reload
        expect(artwork.description).to eq(artwork_params[:artwork][:description])
      end
    end

    context "invalid params" do
      let(:artwork_params) do
        {
          artwork: {
            title: nil
          }
        }
      end

      it_behaves_like "successful response"

      it "does not update the artwork data" do
        artwork.reload
        expect(artwork.description).to_not be_nil
      end
    end
  end

  describe "GET /show" do
    before { get admin_artist_artwork_path(artist_id: artist.friendly_id, id: artwork.id) }

    context "artwork exists" do
      let!(:artwork) { create(:artwork) }

      context "artist exists" do
        it_behaves_like "successful response"
      end
  
      context "artist does not exist" do
        let(:artist) { double(friendly_id: 300) }
  
        it_behaves_like "successful redirect and response"
      end
    end

    context "artwork does not exist" do
      let!(:artwork) { double(id: 300) }

      context "artist exists" do
        it_behaves_like "successful redirect and response"
      end
  
      context "artist does not exist" do
        let(:artist) { double(friendly_id: 300) }
  
        it_behaves_like "successful redirect and response"
      end
    end
  end
end
