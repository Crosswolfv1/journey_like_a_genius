class Api::V1::ItinerariesController < ApplicationController
  def index
    render json: ItinerarySerializer.format_itinerary_list(Itinerary.all), status: :ok
  end

  def create
    binding.pry
    itinerary = Itinerary.new(itinerary_params)
    if itinerary.save
      render json: ItinerarySerializer.format_itinerary_list([itinerary]), status: :ok
    else
    end
  end

  private
  def itinerary_params
    params.require(:itinerary).permit(:city, :duration, :user_id)
  end
end