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

  def show ##two shows dependent on completed or not
    season = Season.find(params[:id])
    season.update(round: 2)
    league_table_info = []

    season.teams.each do |team|
      points = (Game.where(winner_team_id: team.id).length * 3) + (Game.where(result: "X")).length
      wins = Game.where(winner_team_id: team.id).length 
      draws = Game.where(result: "X").length 
      losses = season.round - (wins + draws)
      goals_for = 0
      goals_against = 0
      goal_difference = 0
      (Game.where(home_team_id: team.id).where.not(result: nil)).each do |game|
        goals_for += game.goals_ht
      end
      (Game.where(away_team_id: team.id).where.not(result: nil)).each do |game|
        goals_for += game.goals_at
      end
      (Game.where(home_team_id: team.id).where.not(result: nil)).each do |game|
        goals_against += game.goals_at
      end
      (Game.where(away_team_id: team.id).where.not(result: nil)).each do |game|
        goals_against += game.goals_ht
      end

      team_current_standing = [team.name, team.id, wins, draws, losses, goals_for, goals_against, (goals_for - goals_against), points]
      league_table_info << team_current_standing
    end

    render json: league_table_info.sort_by{|x| x[8]}.reverse
  end
end
