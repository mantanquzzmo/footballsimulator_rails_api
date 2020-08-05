# frozen_string_literal: true

class Api::PlayersController < ApplicationController
  def show
    :authenticate_user!

    player = Player.find(params[:id])
    trainings = Training.where(player_id: params[:id])

    render json: [player, trainings]
  end

  def update
    player_substituting = Player.find(params[:id])
    player_entering = Player.find(params[:substitute])

    player_substituting.update(starting_11: false)

    if player_substituting.starting_11_previously_changed?
      if player_entering.starting_11 === false
        player_entering.update(starting_11: true)
        render json: { message: "Substitution completed" }, status: 200
      else
        render json: { message: "Substitute already in the starting 11" }
      end
    else
      render json: { message: 'Unable to make substitution' }
    end
  end
end
