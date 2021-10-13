require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /index" do
    before { get admin_artist_posts_path(artist.friendly_id) }

    context "artist exists" do
      let(:artist) { create(:artist) }
      let!(:artist_posts) { create_list(:post, 3, artist: artist) }

      it { expect(response.status).to eq(200) }
    end

    context "artist does not exist" do
      let(:artist) { double(friendly_id: 300) }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }

    before { get admin_artist_post_path(artist.friendly_id, artist_post.id) }

    context "post exists" do
      let(:artist_post) { create(:post, artist: artist) }

      it { expect(response.status).to eq(200) }
    end

    context "post does not exist" do
      let(:artist_post) { double(id: 300) }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end
end
