class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :item_itineraries
  has_many :items, through: :item_itineraries
  validates :city, presence: true
  validates :duration, presence: true

  def add_items(items_data)
    if items_data.present?
      items_data = items_data.map do |item|
        item.permit(:name, :address, :item_type, :phone, :opening_hours).to_h
      end
    end
    binding.pry
    items_data.each do | item_data |
      binding.pry
      item = Item.find_or_create_by(name: item_data[:name], address: item_data[:address]) do | new_item |
        new_item.item_type = item_data[:item_type]
        new_item.phone = item_data[:phone]
        new_item.opening_hours = item_data[:opening_hours]
      end
      if item.valid? && item.save
        self.items << item
      end
    end
  end
end
