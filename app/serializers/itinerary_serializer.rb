class ItinerarySerializer

  def self.format_itinerary_lists(itineraries)
    { data:
        itineraries.map do |itinerary|
          {
            id: itinerary.id.to_s,
            type: "itinerary",
            attributes: {
              city: itinerary.city,
              duration: itinerary.duration,
              user_id: itinerary.user.id,
              items: itinerary.items.map do |item|
                 {
                  id: item.id.to_s,
                  item_type: item.item_type,
                  name: item.name,
                  address: item.address,
                  opening_hours: item.opening_hours,
                  phone: item.phone
                 }
                end
            }
          }
        end,
        meta: {
          your_itineraries: itineraries.count
        }
    }
  end

  def self.format_itinerary_list(itinerary)
    
    {data:
      {
        id: itinerary.id,
        type: "itinerary",
        attributes: {
          city: itinerary.city,
          duration: itinerary.duration,
          user_id: itinerary.user.id,
          items: itinerary.items.map do |item|
            {
              id: item.id.to_s,
              item_type: item.item_type,
              name: item.name,
              address: item.address,
              opening_hours: item.opening_hours,
              phone: item.phone
            }
            end
        }
    }}
  end
end