class Itinerary < ApplicationRecord
  belongs_to :user
  validates :city, presence: true
  validates :duration, presence: true
end
