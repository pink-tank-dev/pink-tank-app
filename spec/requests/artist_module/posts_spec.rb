require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:current_artist) { create(:artist) }
  before { login_artist(current_artist) }

  describe "GET /new" do
    before { get new_artist_module_post_path }

    it { expect(response.status).to eq(200) }
  end
  
  describe "POST /create" do
    before { post artist_module_posts_path, params: { post: post_params } }

    context "with valid params" do
      let(:post_params) do
        {
          artist: current_artist,
          title: Faker::Book.title,
          status: :draft,
          body: Faker::Lorem.paragraph
        }
      end

      it do
        expect(response.status).to eq(302)
  
        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      let(:post_params) do
        {
          artist: current_artist,
          title: "",
          status: :draft,
          body: Faker::Lorem.paragraph
        }
      end

      it { expect(response.status).to eq(200) }
    end

    
  end

  describe "GET /edit" do
    let(:artist_post) { create(:post, artist: current_artist) }
    before { get edit_artist_module_post_path(artist_post.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update" do
    let(:artist_post) { create(:post, artist: current_artist) }
    before { put artist_module_post_path(artist_post.id), params: { post: post_params } }

    context "valid params" do
      let(:post_params) do
        { title: Faker::Book.title }
      end

      it do
        expect(response.status).to eq(302)
  
        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "invalid params" do
      let(:post_params) do
        { title: "" }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /show" do
    let(:artist_post) { create(:post, artist: current_artist) }
    before { get artist_module_post_path(artist_post.id) }

    it { expect(response.status).to eq(200) }
  end
end
