require "rails_helper"

RSpec.describe "Itineraries", type: :request do
  describe "Get All Itineraries Endpoint" do
    it "retrieves all itineraries" do
      user_1 = User.create!(name: "Alora")
      user_2 = User.create!(name: "Jeremiah")
      input_1 =  {
        itinerary: {
        city: "San Antonio",
        duration: "half-day",
        user_id: user_1.id,
        items: [
          {
            "name": "Pinkerton's Barbecue",
            "address": "107 W Houston St, San Antonio, TX 78205, USA",
            "item_type": "restaurant",
            "phone": "+1 210-983-0088"
          },
          {
            "name": "Hendrick Arnold Nature Park",
            "address": "8950 Fitzhugh Rd, San Antonio, TX 78252, USA",
            "item_type": "activity",
            "phone": "+1 210-227-1373"
            }
        ]}}
      input_2 = {
        itinerary: {
          city: "Austin",
          duration: "full-day",
          user_id: user_1.id,
          items: [
            {
              "name": "Franklin Barbecue",
              "address": "900 E 11th St, Austin, TX 78702, USA",
              "item_type": "restaurant",
              "phone": "+1 512-653-1187"
            },
            {
              "name": "Zilker Botanical Garden",
              "address": "2220 Barton Springs Rd, Austin, TX 78746, USA",
              "item_type": "activity",
              "phone": "+1 512-477-8672"
            }
          ]
        }}
      input_3 = {
        itinerary: {
          city: "Los Angeles",
          duration: "day-trip",
          user_id: user_2.id,
          items: [
            {
              "name": "The Bazaar by José Andrés",
              "address": "465 La Cienega Blvd, Los Angeles, CA 90048, USA",
              "item_type": "restaurant",
              "phone": "+1 310-246-5555"
            },
            {
              "name": "Griffith Observatory",
              "address": "2800 E Observatory Rd, Los Angeles, CA 90027, USA",
              "item_type": "activity",
              "phone": "+1 213-473-0800"
            }
          ]
        }}
  
      post "/api/v1/itineraries/#{user_1.id}", params: input_1
      post "/api/v1/itineraries/#{user_1.id}", params: input_2
      post "/api/v1/itineraries/#{user_2.id}", params: input_3

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

    it "(sad path) fails to create an itinerary" do
      user_3 = User.create!(name: "Joel")

      itinerary_params = { 
        itinerary: {
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

      expect(response).not_to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors]).to eq(["City can't be blank"]) 

      user_2 = User.create!(name: "Jeremiah")

      itinerary_params = { 
        itinerary: {
          city: "Tokyo", 
          user_id: user_2.id,
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

      post "/api/v1/itineraries/#{user_2.id}", params: itinerary_params

      expect(response).not_to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors]).to eq(["Duration can't be blank"]) 
    end
  end
end