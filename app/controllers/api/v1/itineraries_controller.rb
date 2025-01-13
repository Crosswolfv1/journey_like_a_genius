class Api::V1::ItinerariesController < ApplicationController
  def index
    render json: ItinerarySerializer.format_itinerary_list(Itinerary.all), status: :ok
  end

  def create
    
  end
end