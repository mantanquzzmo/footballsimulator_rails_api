class Api::RoundsController < ApplicationController
  def show
    season = Team.find(params[:team_id]).seasons.last(1)[0]
    games = Game.where(season_id: season.id, round: params[:round])
      
    render json: games, status: 200
  end
end
