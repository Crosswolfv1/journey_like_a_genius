class Api::V1::ItinerariesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    render json: ItinerarySerializer.format_itinerary_lists(Itinerary.all), status: :ok
  end

  def create
    itinerary = Itinerary.new(itinerary_params)
    itinerary.user_id = params[:user_id]
    if itinerary.save
      itinerary.add_items(params[:itinerary][:items]) if params[:itinerary][:items].present? 
      render json: ItinerarySerializer.format_itinerary_list([itinerary]), status: :ok
    else
      render json: { errors: itinerary.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private
  
  def itinerary_params
    params.require(:itinerary).permit(:city, :duration)
  end
end