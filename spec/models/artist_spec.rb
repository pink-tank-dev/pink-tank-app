require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "relations" do
    it { is_expected.to have_many(:posts) }
  end
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:about) }
    it { is_expected.to validate_presence_of(:statement) }
  end
end
