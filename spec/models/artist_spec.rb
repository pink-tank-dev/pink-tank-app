require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:about) }
    it { is_expected.to validate_presence_of(:statement) }
    it { is_expected.to validate_presence_of(:instagram) }
  end
end
