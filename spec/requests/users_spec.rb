require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before { get users_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "GET /new" do
    before { get new_user_path }
    it { expect(response).to have_http_status(:success) }
  end

  describe "POST /create" do
    before { post users_path, params: { user: user_params } }

    context "valid params" do
      let(:user_params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: "pinktank",
          password_confirmation: "pinktank"
        }
      end
      
      it "creates the user and redirects to the user" do
        expect(response).to have_http_status(:found)

        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    context "invalid params" do
      let(:user_params) do
        {
          name: Faker::Name.name,
          email: "",
          password: "pinktank",
          password_confirmation: "pinktank"
        }
      end
      
      it "does not create the user" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }
    before { get edit_user_path(user) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /update" do
    let(:user) { create(:user) }
    before { put user_path(user), params: { user: user_params} }

    context "valid params" do
      let(:user_params) do
        {
          name: "Batman"
        }
      end

      it "updates the user and redirects to the user" do
        expect(response).to have_http_status(:found)

        follow_redirect!
        expect(response).to have_http_status(:success)
      end

      it { expect(user.reload.name).to eq("Batman") }
    end

    context "invalid params" do
      let(:user_params) do
        {
          name: ""
        }
      end

      it "does not update the user" do
        expect(response).to have_http_status(:success)
      end

      it { expect(user.reload.name).not_to eq("") }
    end
  end

  describe "GET /edit_password" do
    let(:user) { create(:user) }
    before { get edit_password_user_path(user) }
    it { expect(response).to have_http_status(:success) }
  end

  describe "PUT /update_password" do
    let(:user) { create(:user) }
    before { put update_password_user_path(user), params: { user: user_params } }
    let(:user_params) { { password: "newpass", password_confirmation: "newpass" } }
    it "updates the password and redirects to the user page" do
      expect(response).to have_http_status(:found)

      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    before { get user_path(user) }

    context "user exists" do
      let(:user) { create(:user) }
      it { expect(response).to have_http_status(:success) }
    end

    context "user does not exist" do
      let(:user) { 1 }
      it "redirects to index" do
        expect(response).to have_http_status(:found)

        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
