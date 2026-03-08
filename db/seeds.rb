# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user_1 = User.find_or_create_by!(name: "Alora")
user_2 = User.find_or_create_by!(name: "Jeremiah")
user_3 = User.find_or_create_by!(name: "Joel")
user_4 = User.find_or_create_by!(name: "James")
user_5 = User.find_or_create_by!(name: "Guest")

itinerary_1 = Itinerary.find_or_create_by!(
  city: "Paris",
  duration: "half",
  user: user_1
)

item_1 = Item.find_or_create_by!(
  item_type: "activity",
  name: "Musée d'Orsay",
  address: "Esplanade Valéry Giscard d'Estaing, 75007 Paris, France"
) do |item|
  item.opening_hours = [
    "Monday: Closed",
    "Tuesday: 9:30 AM – 6:00 PM",
    "Wednesday: 9:30 AM – 6:00 PM",
    "Thursday: 9:30 AM – 6:00 PM",
    "Friday: 9:30 AM – 6:00 PM",
    "Saturday: 9:30 AM – 6:00 PM",
    "Sunday: 9:30 AM – 6:00 PM"
  ]
  item.phone = "+33 1 40 49 48 14"
end

# Create the join record
ItemItinerary.find_or_create_by!(
  itinerary: itinerary_1,
  item: item_1
)