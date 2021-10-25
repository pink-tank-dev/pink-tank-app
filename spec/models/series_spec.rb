require 'rails_helper'

RSpec.describe Series, type: :model do
  describe "relations" do
    it { should belong_to(:exhibition) }
    it { should belong_to(:artist) }
    it { should have_many(:series_artworks) }
    it { should have_many(:artworks).through(:series_artworks) } 
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:exhibition) }
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:artworks) }

    describe "#artworks_belong_to_series_artist" do
      let(:artist) { create(:artist) }
      context "and only artworks from 1 artist is featured" do
        let(:artworks) { create_list(:artwork, 2, artist: artist) }
        let(:series) { build(:series, artworks: artworks) }

        it { expect(series.valid?).to eq(true) }
      end

      context "and artworks from multiple artists are featured" do
        let(:artwork_1) { create(:artwork, artist: artist) }
        let(:artwork_2) { create(:artwork) }
        let(:series) { build(:series, artworks: [artwork_1, artwork_2]) }

        it { expect(series.valid?).to eq(false) }
      end
    end
  end
end
