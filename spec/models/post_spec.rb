require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "relations" do
    it { is_expected.to belong_to(:artist) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(%i[draft posted]) }
  end
end
