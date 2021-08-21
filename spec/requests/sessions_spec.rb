require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    before { get root_path }

    it { expect(response.status).to eq(200) }
  end

  describe "POST /login_user" do
    before { post login_user_path, params: login_user_params }

    context "with valid params" do
      let(:user) { create(:user) }
      let(:login_user_params) do
        {
          email: user.email,
          password: user.password
        }
      end

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      let(:user) { double(email: "fake@email.com", password: "pa55word") }
      let(:login_user_params) do
        {
          email: user.email,
          password: user.password
        }
      end

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST /login_artist" do
    before { post login_artist_path, params: login_artist_params }

    context "with valid params" do
      let(:artist) { create(:artist) }
      let(:login_artist_params) do
        {
          email: artist.email,
          password: artist.password
        }
      end

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      let(:artist) { double(email: "fake@email.com", password: "pa55word") }
      let(:login_artist_params) do
        {
          email: artist.email,
          password: artist.password
        }
      end

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end
end
