require 'rails_helper'

RSpec.describe SocialMedium, type: :model do
  describe "relations" do
    it { should belong_to(:artist) }
  end

  describe "validations" do
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:handle) }
    it { should validate_presence_of(:medium) }
  end

  describe "enums" do
    it { should define_enum_for(:medium).with_values(%i[instagram facebook twitter]) }
  end
end
