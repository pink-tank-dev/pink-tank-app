require 'rails_helper'

RSpec.describe SeriesArtwork, type: :model do
  describe "relations" do
    it { should belong_to(:series) }
    it { should belong_to(:artwork) } 
  end
end
