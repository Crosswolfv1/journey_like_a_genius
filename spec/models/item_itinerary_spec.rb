require "rails_helper"

RSpec.describe ItemItinerary, type: :model do
  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :itinerary}
  end
end