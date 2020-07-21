require "round_robin_tournament"

class Api::SeasonsController < ApplicationController
  include TeamsCreator, PlayersCreator

  def create
    :authenticate_user!

    cpu_opponent = User.create(email: 'cpu_opponent' + current_user.id.to_s + '@mail.com', password: 'password')
    player_team = Team.where(id: params[:team_id])
    season_teams_names = [player_team[0].name]
    season = Season.create()
    season.teams << player_team[0]

    (0..4).each do |i|
      team_name = team_name_generator(i)
      team = Team.create(name: team_name,
                         primary_color: 'white', ## add randomizer
                         secondary_color: 'red',
                         user_id: cpu_opponent.id)

      if team.persisted?
        players = generate_players(team.id)
        season.teams << team
        season_teams_names << team.name
      else
        render json: { error: team.errors.full_messages }, status: 422
      end
    end

    schedule = RoundRobinTournament.schedule(season.teams.map { |x| x.name })

    render json: [season.teams, schedule]
  end
end


