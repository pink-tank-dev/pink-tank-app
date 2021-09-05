require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "relations" do
    it { should belong_to(:artist) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(%i[draft published]) }
  end
end
