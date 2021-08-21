require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let!(:current_artist) { create(:artist) }
  before { login_artist(current_artist) }

  describe "GET /show" do
    before { get artist_module_profile_path }

    it { expect(response.status).to eq(200) }
  end

  describe "GET /edit" do
    before { get edit_artist_module_profile_path }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update" do
    before { put artist_module_profile_path, params: { artist: artist_params} }

    context "with valid params" do
      let(:artist_params) do
        {
          name: Faker::Name.name_with_middle
        }
      end

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      let(:artist_params) do
        {
          name: ""
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /edit_password" do
    before { get edit_password_artist_module_profile_path }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update_password" do
    before { put update_password_artist_module_profile_path, params: { artist: password_params } }

    let(:password_params) do
      {
        password: Faker::Internet.password
      }
    end

    it do
      expect(response.status).to eq(302)

      follow_redirect!
      expect(response.status).to eq(200)
    end
  end
end
