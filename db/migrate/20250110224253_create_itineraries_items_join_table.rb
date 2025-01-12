class CreateItinerariesItemsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :itineraries, :items do |t|
      # t.index [:itinerary_id, :item_id]
      # t.index [:item_id, :itinerary_id]
    end
  end
end
