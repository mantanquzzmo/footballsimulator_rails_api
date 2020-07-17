class Api::PlayersController < ApplicationController
  def show
    :authenticate_user!

    player = Player.find(params[:id])

    trainings = Training.where(player_id: params[:id])
    render json: [player, trainings]
  end
end
