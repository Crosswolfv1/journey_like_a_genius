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

      itinerary_params = { itinerary: {city: "Tokyo", duration: "full", user_id: user_3.id } }

      post api_v1_itineraries_path, params: itinerary_params
      
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][0][:attributes][:city]).to eq("Tokyo")
      expect(json[:data][0][:attributes][:duration]).to eq("full")
      expect(json[:data][0][:attributes][:user_id]).to eq(user_3.id)
    end
  end
end