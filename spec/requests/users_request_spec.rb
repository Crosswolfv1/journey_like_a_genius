require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "Get All Users Endpoint" do
    it "retrieves all users" do
      user_1 = User.create!(name: "Alora")
      user_2 = User.create!(name: "Jeremiah")
      user_3 = User.create!(name: "Joel")

      get api_v1_users_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:name)
    end

    it "retrieves a single user" do
      user_1 = User.create!(name: "Alora")
      user_2 = User.create!(name: "Jeremiah")

      get  "/api/v1/users/#{user_1.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to eq("Alora")
      expect(json[:data][:type]).to eq("user")
      expect(json[:data][:id]).to eq(user_1.id.to_s)

      get  "/api/v1/users/#{user_2.id}"
      expect(response).to be_successful
      json2 = JSON.parse(response.body, symbolize_names: true)

      expect(json2[:data][:attributes]).to have_key(:name)
      expect(json2[:data][:attributes][:name]).to eq("Jeremiah")
      expect(json2[:data][:type]).to eq("user")
      expect(json2[:data][:id]).to eq(user_2.id.to_s)

      expect(json != json2).to eq(true)
    end

    it "(sad path) retrieve a specific user" do
      get  "/api/v1/users/99999999"

      expect(response).not_to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("User not found")
    end
  end
end