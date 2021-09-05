require 'rails_helper'

RSpec.describe "Exhibitions", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /index" do
    before { get admin_exhibitions_path }

    it { expect(response.status).to eq(200) }
  end

  describe "GET /new" do
    before { get new_admin_exhibition_path }

    it { expect(response.status).to eq(200) }
  end

  describe "POST /create" do
    before { post admin_exhibitions_path, params: exhibition_params }

    context "valid params" do
      let(:exhibition_params) do
        {
          exhibition: {
            start_at: DateTime.current,
            end_at: 30.days.from_now,
            title: Faker::Lorem.question,
            description: Faker::Lorem.paragraph
          }
        }
      end

      it do
        expect(response.status).to eq(302)
        follow_redirect!
        expect(response.status).to eq(200)
      end

      it { expect(Exhibition.last.title).to eq(exhibition_params[:exhibition][:title]) }
    end

    context "invalid params" do
      let(:exhibition_params) do
        {
          exhibition: {
            title: Faker::Lorem.question
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /edit" do
    before { get edit_admin_exhibition_path(exhibition.id) }

    context "exhibition exists" do
      let(:exhibition) { create(:exhibition) }

      it { expect(response.status).to eq(200) }
    end

    context "exhibition does not exist" do
      let(:exhibition) { double(id: 300) }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT /update" do
    let(:exhibition) { create(:exhibition) }

    before { put admin_exhibition_path(exhibition.id), params: exhibition_params }

    context "valid params" do
      let(:exhibition_params) do
        {
          exhibition: {
            title: Faker::Lorem.question
          }
        }
      end

      it do
        expect(response.status).to eq(302)
        follow_redirect!
        expect(response.status).to eq(200)
      end

      it { expect(exhibition.reload.title).to eq(exhibition_params[:exhibition][:title]) }
    end

    context "invalid params" do
      let(:exhibition_params) do
        {
          exhibition: {
            title: nil,
            start_at: nil,
            end_at: nil
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /show" do
    before { get admin_exhibition_path(exhibition.id) }

    context "exhibition exists" do
      let(:exhibition) { create(:exhibition) }

      it { expect(response.status).to eq(200) }
    end

    context "exhibition does not exist" do
      let(:exhibition) { double(id: 300) }

      it do
        expect(response.status).to eq(302)

        follow_redirect!
        expect(response.status).to eq(200)
      end
    end
  end
end
