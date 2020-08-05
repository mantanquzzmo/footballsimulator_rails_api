class Api::RoundsController < ApplicationController

  include GamesDecider
  def show
    season = Team.find(params[:team_id]).seasons.last(1)[0]
    games = Game.where(season_id: season.id, round: params[:round])
      
    render json: games, status: 200
  end

  def update
    games = Game.where(season_id: params[:season_id], round: params[:round])
    
    games_decider(games)

    if games[0].result != nil
      Season.find(games[0].season_id).update(round: games[0].round)
    end

    render json: games, status: 200
  end
end
