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
      context "when artworks empty" do
      end

      context "when artworks not empty" do
        context "and only artworks from 1 artist is featured" do
          
        end

        context "and artworks from multiple artists are featured" do
          
        end
      end
    end
  end
end
