class Api::V1::ItinerariesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    render json: ItinerarySerializer.format_itinerary_list(Itinerary.all), status: :ok
  end

  def create
    params[:itinerary][:user_id] = params[:itinerary][:user_id].to_i
    itinerary = Itinerary.new(itinerary_params)
    if itinerary.save
      if params[:itinerary][:items].each do | item_data |
        item = Item.find_or_create_by(name: item_data[:name], address: item_data[:address]) do | new_item |
          new_item.item_type = item_data[:item_type]
          new_item.phone = item_data[:phone]
          new_item.opening_hours = item_data[:opening_hours]

        end
        itinerary.items << item 
      end
    end
      render json: ItinerarySerializer.format_itinerary_list([itinerary]), status: :ok
    else
      render json: { errors: itinerary.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def itinerary_params
    params.require(:itinerary).permit(:city, :duration, :user_id)
  end

  def item_params(item_data)
    item_data.permit(:name, :address, :item_type, :phone, opening_hours: [])
  end
end