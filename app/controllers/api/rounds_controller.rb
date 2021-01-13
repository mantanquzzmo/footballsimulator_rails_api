class Api::RoundsController < ApplicationController

  include GamesDecider, SeasonDecider
  def show
    season = Team.find(params[:team_id]).seasons.last(1)[0]
    games = Game.where(season_id: season.id, round: params[:round])
      
    render json: games, status: 200
  end

  def update

    season = Season.find(params[:season_id])

    games = Game.where(season_id: params[:season_id], round: params[:round])
    games_decider(games)

    if games[0].round != nil then
      season.update(round: games[0].round)
    end

    if season.total_rounds == params[:round].to_i
      season_decider(season)

      render json: [games, season], status: 200
      return
    end

    render json: [games, season], status: 200
  end
end
