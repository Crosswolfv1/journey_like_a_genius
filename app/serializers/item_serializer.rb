class ItemSerializer

  def self.format_item_list(items)
    { data:
        items.map do |item|
          {
            id: item.id.to_s,
            type: "item",
            attributes: {
              item_type: item.item_type,
              name: item.name,
              address: item.address,
              opening_hours: item.opening_hours,
              phone: item.phone,
            }
          }
        end
    }
  end
end