class Api::V1::ItemsItinerariesController < ApplicationController
  rescue_from ArgumentError, with: :invalid_parameters
  def create
    itinerary = Itinerary.find_by(id: params[:itinerary_id])

    items = Items.joins()
  end

  private

  def invalid_parameters(exception)
    render json: ErrorSerializer.format_error(ErrorMessage.new(exception, 404)), status: :not_found
  end
end

