require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /index" do
    let(:artist) { create(:artist) }
    let(:posts) { create_list(:post, 3, artist: artist) }
    before { get admin_artist_posts_path(artist.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }
    let(:artist_post) { create(:post, artist: artist) }
    before { get admin_artist_post_path(artist.id, artist_post.id) }

    it { expect(response.status).to eq(200) }
  end
end
