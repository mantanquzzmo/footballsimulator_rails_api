# frozen_string_literal: true

class Api::SeasonsController < ApplicationController
  include TeamsCreator, PlayersCreator

  def create
    :authenticate_user!

    cpu_opponent = User.create(email: 'cpu_opponent' + rand(0..1000).to_s + '@mail.com', password: 'password')
    player_team = Team.where(id: params[:team_id])
    season_teams = [player_team[0]]

    (0..4).each do |i|
      team_name = team_name_generator(i)
      team = Team.create(name: team_name,
                         primary_color: 'white',
                         secondary_color: 'red',
                         user_id: cpu_opponent.id)

      if team.persisted?
        players = generate_players(team.id)
        season_teams << team
      else
        render json: { error: team.errors.full_messages }, status: 422
      end
    end
  end
end
