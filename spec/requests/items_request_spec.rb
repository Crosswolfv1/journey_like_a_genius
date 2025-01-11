require "rails_helper"

RSpec.describe "Items", type: :request do
  describe "Get All Items Endpoint" do
    it "retrieves all Items" do

      activity_1 = Item.create!(item_type: "activity", name: "Musée d'Orsay", address: "Esplanade Valéry Giscard d'Estaing, 75007 Paris, France", opening_hours: ["Monday: Closed", "Tuesday: 9:30 AM – 6:00 PM", "Wednesday: 9:30 AM – 6:00 PM", "Thursday: 9:30 AM – 6:00 PM", "Friday: 9:30 AM – 6:00 PM", "Saturday: 9:30 AM – 6:00 PM", "Sunday: 9:30 AM – 6:00 PM"], phone: "+33 1 40 49 48 14")
      restaurant_1 = Item.create!(item_type: "restaurant", name: "Baguett's Café", address: "33 Rue de Richelieu, 75001 Paris, France", opening_hours: [ "Monday: 8:30 AM – 4:00 PM", "Tuesday: 8:30 AM – 4:00 PM", "Wednesday: 8:30 AM – 4:00 PM", "Thursday: 8:30 AM – 4:00 PM", "Friday: 8:30 AM – 4:00 PM", "Saturday: 9:00 AM – 4:30 PM", "Sunday: 9:00 AM – 4:30 PM"], phone: "None reported")

      get api_v1_items_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(2)
      expect(json[:data][0][:attributes]).to have_key(:item_type)
      expect(json[:data][0][:attributes]).to have_key(:name)
      expect(json[:data][0][:attributes]).to have_key(:address)
      expect(json[:data][0][:attributes]).to have_key(:opening_hours)
      expect(json[:data][0][:attributes]).to have_key(:phone)
    end
  end
end