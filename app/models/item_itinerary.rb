class ItemItinerary < ApplicationRecord
  belongs_to :item
  belongs_to :itinerary
end
