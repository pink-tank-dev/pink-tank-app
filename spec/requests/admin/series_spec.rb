require 'rails_helper'

RSpec.describe "Admin::Series", type: :request do
  let!(:current_user) { create(:user) }
  before { login_user(current_user) }

  describe "GET /new" do
    let(:exhibition) { create(:exhibition) }
    before { get new_admin_exhibition_series_path(exhibition.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "POST /create" do
    let!(:exhibition) { create(:exhibition) }
    let!(:artist) { create(:artist) }

    before { post admin_exhibition_series_index_path(exhibition.id), params: series_params }

    context "valid params" do
      let(:series_params) do
        {
          series: {
            title: Faker::Book.title,
            description: Faker::Lorem.paragraph,
            artist_id: artist.id
          }
        }
      end

      it do
        expect(response.status).to eq(302)
        follow_redirect!
  
        expect(response.status).to eq(200)
      end
  
      it do
        expect(exhibition.reload.series.last).to_not be_nil
        expect(exhibition.reload.series.last.title).to eq(series_params[:series][:title])
      end
    end

    context "invalid params" do
      let(:series_params) do
        {
          series: {
            title: Faker::Book.title,
            description: Faker::Lorem.paragraph
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /edit" do
    let(:artist) { create(:artist) }
    let(:exhibition) { create(:exhibition) }
    let(:series) { create(:series, artist: artist, exhibition: exhibition) }

    before { get edit_admin_exhibition_series_path(exhibition.id, series.id) }

    it { expect(response.status).to eq(200) }
  end

  describe "PUT /update" do
    let(:artist) { create(:artist) }
    let(:exhibition) { create(:exhibition) }
    let(:series) { create(:series, artist: artist, exhibition: exhibition) }

    before { put admin_exhibition_series_path(exhibition.id, series.id), params: series_params }

    context "valid params" do
      let(:series_params) do
        {
          series: {
            title: Faker::Book.title,
            description: Faker::Lorem.paragraph
          }
        }
      end

      it do
        expect(response.status).to eq(302)
        follow_redirect!
  
        expect(response.status).to eq(200)
      end

      it do
        expect(series.reload.title).to eq(series_params[:series][:title])
        expect(series.reload.description).to eq(series_params[:series][:description])
      end
    end

    context "invalid params" do
      let(:series_params) do
        {
          series: {
            artist_id: nil
          }
        }
      end

      it { expect(response.status).to eq(200) }
    end
  end

  describe "GET /show" do
    let(:artist) { create(:artist) }
    let(:exhibition) { create(:exhibition) }
    let(:series) { create(:series, artist: artist, exhibition: exhibition) }

    before { get admin_exhibition_series_path(exhibition.id, series.id) }

    it { expect(response.status).to eq(200) }
  end
end
