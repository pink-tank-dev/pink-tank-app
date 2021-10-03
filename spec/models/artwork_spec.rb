require 'rails_helper'

RSpec.describe Artwork, type: :model do
  describe "relations" do
    it { should belong_to(:artist) } 
  end

  describe "validations" do
    it { should validate_presence_of(:file) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:medium) }
    it { should validate_presence_of(:measurements) }
    it { should validate_presence_of(:status) }
  end
end
