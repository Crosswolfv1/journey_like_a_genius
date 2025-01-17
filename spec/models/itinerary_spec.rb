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

  describe "model methods" do    
    it "add_items" do
      input =  {
      city: "San Antonio",
      duration: "half-day",
      items: [
        {
          "name": "Pinkerton's Barbecue",
          "address": "107 W Houston St, San Antonio, TX 78205, USA",
          "item_type": "restaurant",
          "phone": "+1 210-983-0088",
          "opening_hours": ["10:00 AM - 9:00 PM"]
        },
        {
          "name": "Hendrick Arnold Nature Park",
          "address": "8950 Fitzhugh Rd, San Antonio, TX 78252, USA",
          "item_type": "activity",
          "phone": "+1 210-227-1373",
          "opening_hours": ["8:00 AM - 7:00 PM"]
        }
      ]}
      
      itinerary = Itinerary.new(input.except(:items))
      itinerary.add_items(input[:items])
      expect(Item.all.count).to eq(2)
    end

    it "sad path add_items(missing attributes)" do
      input =  {
      city: "San Antonio",
      duration: "half-day",
      items: [
        {
          "name": "Pinkerton's Barbecue",
          "address": "107 W Houston St, San Antonio, TX 78205, USA",
          "phone": "+1 210-983-0088"
        },
        {
          "name": "Hendrick Arnold Nature Park",
          "item_type": "activity",
          "phone": "+1 210-227-1373"
        }
      ]}
      itinerary = Itinerary.new(input.except(:items))
      itinerary.add_items(input[:items])
      expect(Item.all.count).to eq(0)
    end
  end
  
end
