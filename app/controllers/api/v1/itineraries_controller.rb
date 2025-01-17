class Api::V1::ItinerariesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    render json: ItinerarySerializer.format_itinerary_lists(Itinerary.all), status: :ok
  end

  def create
    user = User.find_by(id: params[:itinerary_user_id])
    itinerary = Itinerary.new(itinerary_params.except(:items))
    itinerary.user_id = user.id
    if itinerary.save
      itinerary.add_items(itinerary_params[:items]) if itinerary_params[:items].present? 
      render json: ItinerarySerializer.format_itinerary_list(itinerary), status: :ok
    else
      render json: { errors: itinerary.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private
  
  def itinerary_params
    params.require(:itinerary).permit(:city, :duration, items: [:name, :address, :item_type, :phone, :opening_hours])
  end
end