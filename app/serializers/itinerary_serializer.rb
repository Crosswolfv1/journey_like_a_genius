class ItinerarySerializer

  def self.format_itinerary_list(itineraries)
    { data:
        itineraries.map do |itinerary|
          {
            id: itinerary.id.to_s,
            type: "itinerary",
            attributes: {
              city: itinerary.city,
              duration: itinerary.duration,
              user_id: itinerary.user.id,
            }
          }
        end
    }
  end
end