require "rails_helper"

RSpec.describe "Itineraries", type: :request do
  describe "Get All Itineraries Endpoint" do
    it "retrieves all itineraries" do
      user_1 = User.create!(name: "Alora")
      user_2 = User.create!(name: "Jeremiah")

      itinerary_1 = Itinerary.create!(city: "Paris", duration: "half", user_id: user_1.id)
      itinerary_2 = Itinerary.create!(city: "New Orleans", duration: "full", user_id: user_1.id)
      itinerary_3 = Itinerary.create!(city: "San Antonio", duration: "half", user_id: user_2.id)

      get api_v1_itineraries_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:city)
      expect(json[:data][0][:attributes]).to have_key(:duration)
      expect(json[:data][0][:attributes]).to have_key(:user_id)
    end
  end
  
  describe "Create an Itinerary Endpoint" do
    it "can create an itinerary" do
      user_3 = User.create!(name: "Joel")

      itinerary_params = { itinerary: {city: "Tokyo", duration: "full"} }
      post "/api/v1/itineraries/#{user_3.id}", params: itinerary_params
      
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:city]).to eq("Tokyo")
      expect(json[:data][:attributes][:duration]).to eq("full")
      expect(json[:data][:attributes][:user_id]).to eq(user_3.id)
    end

    it "can create an itinerary with its associated items" do
      user_3 = User.create!(name: "Joel")

      itinerary_params = { 
        itinerary: {
          city: "Tokyo", 
          duration: "half", 
          user_id: user_3.id,
           items: [
            {
              item_type: "activity",
              name: "Tokyo Tower",
              address: "4 Chome-2-8 Shibakoen, Minato City, Tokyo, Japan",
              phone: "81 3-3433-5111"
            },
            {
              item_type: "restaurant",
              name: "Men Kurai",
              address: "3 Chome-5-2 Sotokanda, Chiyoda City, Tokyo, Japan",
               phone: "123-456-7890"
            }
          ]
        } 
      }

      post "/api/v1/itineraries/#{user_3.id}", params: itinerary_params

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:city]).to eq("Tokyo")
      expect(json[:data][:attributes][:duration]).to eq("half")
      expect(json[:data][:attributes][:user_id]).to eq(user_3.id)

      itinerary = Itinerary.last
      expect(itinerary.items.count).to eq(2)
    
      expect(itinerary.items.first.item_type).to eq("activity")
      expect(itinerary.items.first.name).to eq("Tokyo Tower")
      expect(itinerary.items.first.address).to eq("4 Chome-2-8 Shibakoen, Minato City, Tokyo, Japan")
      expect(itinerary.items.first.phone).to eq("81 3-3433-5111")

      expect(itinerary.items.second.item_type).to eq("restaurant")
      expect(itinerary.items.second.name).to eq("Men Kurai")
      expect(itinerary.items.second.address).to eq("3 Chome-5-2 Sotokanda, Chiyoda City, Tokyo, Japan")
      expect(itinerary.items.second.phone).to eq("123-456-7890")
    end
  end
end