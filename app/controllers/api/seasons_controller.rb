# frozen_string_literal: true

require 'round_robin_tournament'

class Api::SeasonsController < ApplicationController
  include GamesCreator, TeamsCreator, PlayersCreator

  def create
    :authenticate_user!

    cpu_opponent = User.create(email: 'cpu_opponent' + current_user.id.to_s + '@mail.com', password: 'password')
    player_team = Team.where(id: params[:team_id])
    season = Season.create
    season.teams << player_team[0]

    (0..4).each do |i|
      team_name = team_name_generator(i)
      team = Team.create(name: team_name,
                         primary_color: 'white', 
                         secondary_color: 'red',
                         user_id: cpu_opponent.id,
                         cpu_team: true)

      if team.persisted?

        players = generate_players(team.id)
        season.teams << team
      else
        render json: { error: team.errors.full_messages }, status: 422
      end
    end
    schedule = generate_games(season)
    season.update(total_rounds: schedule.length)

    render json: [season, season.teams, schedule], status: 200
  end
end
