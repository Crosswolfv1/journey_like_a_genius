require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :item_itineraries}
    it {should have_many(:items) .through(:item_itineraries)}
  end

  describe "validations" do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:duration) }
  end
end
