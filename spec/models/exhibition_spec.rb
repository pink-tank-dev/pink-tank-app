require 'rails_helper'

RSpec.describe Exhibition, type: :model do
  describe "relations" do
    it { should have_many(:series) }
    it { should have_many(:artworks).through(:series) } 
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
  end
end
