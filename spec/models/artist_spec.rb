require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "relations" do
    it { should have_one(:series) }
    it { should have_many(:posts) }
    it { should have_many(:social_media) }
  end
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:about) }
    it { should validate_presence_of(:statement) }
  end
end
