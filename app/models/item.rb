class Item < ApplicationRecord
  has_many :item_itineraries
  has_many :itineraries, through: :item_itineraries
  validates :item_type, presence: true
  validates :name, presence: true
  validates :address, presence: true
  # validates :opening_hours, presence: true
  validates :phone, presence: true
end
