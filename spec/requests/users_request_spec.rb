require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "Get All Users Endpoint" do
    it "retrieves all users" do
      user_1 = User.create!(name: "Alora")
      user_2 = User.create!(name: "Jeremiah")
      user_3 = User.create!(name: "Joel")

      get "/api/v1/users"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:name)
    end
  end
end