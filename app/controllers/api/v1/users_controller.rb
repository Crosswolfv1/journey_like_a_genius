class Api::V1::UsersController < ApplicationController
  def index
      render json: UserSerializer.format_user_list(User.all), status: :ok
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: UserSerializer.format_user(user), status: :ok
    else 
      render json: { error: "User not found" }, status: :not_found
    end
  end
end