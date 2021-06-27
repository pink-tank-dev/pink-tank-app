require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    before { get artist_posts_path(artist) }
    context "artist exists" do
      let(:artist) { create(:artist) }
      it { expect(response).to have_http_status(:success) }
    end
  end
end
