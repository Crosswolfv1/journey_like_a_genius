class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :item_itineraries
  has_many :items, through: :item_itineraries
  validates :city, presence: true
  validates :duration, presence: true
end
