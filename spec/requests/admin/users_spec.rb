require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /index" do
    before { get admin_users_path }

    it { expect(response.status).to eq(200) }
  end

  describe "GET /new" do
    before { get new_admin_user_path }

    it { expect(response.status).to eq(200) }
  end

  describe "POST /create" do
    before { post admin_users_path, params: { user: user_params } }

    context "valid params" do
      let(:user_params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: "pinktank"
        }
      end
      
      it "creates the user and redirects to the user" do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end

    context "invalid params" do
      let(:user_params) do
        {
          name: Faker::Name.name,
          email: "",
          password: "pinktank"
        }
      end
      
      it "does not create the user" do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }
    before { get edit_admin_user_path(user.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update" do
    let(:user) { create(:user) }
    before { put admin_user_path(user.id), params: { user: user_params } }

    context "valid params" do
      let(:user_params) { { name: "Batman" } }

      it "updates the user and redirects to the user" do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end

      it { expect(user.reload.name).to eq("Batman") }
    end

    context "invalid params" do
      let(:user_params) { { name: "" } }

      it "does not update the user" do
        expect(response.status).to eq(200)
      end

      it { expect(user.reload.name).not_to eq("") }
    end
  end

  describe "GET /edit_password" do
    let(:user) { create(:user) }
    before { get edit_password_admin_user_path(user.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update_password" do
    let(:user) { create(:user) }
    before do
      put update_password_admin_user_path(user.id), params: { user: user_params }
    end

    let(:user_params) { { password: "newpass" } }
    it do
      expect(response.status).to eq(302)

      follow_redirect!
      expect(response.status).to eq(200)
    end
  end

  describe "GET /show" do
    before { get admin_user_path(user.id) }

    context "user exists" do
      let(:user) { create(:user) }
      it { expect(response.status).to eq(200) }
    end

    context "user does not exist" do
      let(:user) { double(id: 16568) }
      it "redirects to index" do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end
end
