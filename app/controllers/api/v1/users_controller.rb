class Api::V1::UsersController < ApplicationController
  def index
    render json: UserSerializer.format_user_list(User.all), status: :ok
  end
end