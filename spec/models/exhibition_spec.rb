require 'rails_helper'

RSpec.describe Exhibition, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }
  end
end
