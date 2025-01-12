class ChangeItemsItinerariesToItemItineraries < ActiveRecord::Migration[7.1]
  def change
    rename_table :items_itineraries, :item_itineraries
  end
end
