class Api::PlayersController < ApplicationController
  def show
    :authenticate_user!

    player = Player.find(params[:id])
    render json: player
  end
end
