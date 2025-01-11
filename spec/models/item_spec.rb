require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    # it {should have_many(:itineraries) .through(:itinerary_items)}
  end

  describe "validations" do
    it { should validate_presence_of(:item_type) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:opening_hours) }
    it { should validate_presence_of(:phone) }
  end
end
