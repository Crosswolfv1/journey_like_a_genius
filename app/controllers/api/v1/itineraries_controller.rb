class Api::V1::ItinerariesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    render json: ItinerarySerializer.format_itinerary_lists(Itinerary.all), status: :ok
  end

  def create
    itinerary = Itinerary.new(itinerary_params.except(:items))
    binding.pry
    itinerary.user_id = params[:itinerary_user_id].to_i
    binding.pry
    if itinerary.save
      binding.pry
      itinerary.add_items(itinerary_params[:items]) if itinerary_params[:items].present? 
      render json: ItinerarySerializer.format_itinerary_list([itinerary]), status: :ok
    else
      binding.pry
      render json: { errors: itinerary.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  private
  
  def itinerary_params
    permitted_params = params.require(:itinerary).permit(:city, :duration, items: [:name, :address, :item_type, :phone, :opening_hours])
    permitted_params[:items] = permitted_params[:items].map { |item| item.to_h } if permitted_params[:items].present?
    permitted_params
  end
end