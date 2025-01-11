class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_item_list(Item.all), status: :ok
  end
end