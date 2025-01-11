require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  describe "relationships" do
    it {should belong_to :user}
  end

  describe "validations" do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:duration) }
  end
end
