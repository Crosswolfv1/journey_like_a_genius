class Api::V1::ItinerariesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    render json: ItinerarySerializer.format_itinerary_list(Itinerary.all), status: :ok
  end

  def create
    # binding.pry
    params[:itinerary][:user_id] = params[:itinerary][:user_id].to_i
    itinerary = Itinerary.new(itinerary_params)
    if itinerary.save
      render json: ItinerarySerializer.format_itinerary_list([itinerary]), status: :ok
    else
      render json: { errors: itinerary.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def itinerary_params
    params.require(:itinerary).permit(:city, :duration, :user_id)
  end
end