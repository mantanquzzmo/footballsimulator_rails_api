# frozen_string_literal: true

class Api::TeamsController < ApplicationController

  include PlayersCreator

  def index
    teams_to_display = []

    if current_user
      teams = Team.where(user_id: current_user.id, cpu_team: false ).last(3)
      teams_to_display << teams
    else
      teams = Team.all
      teams_to_display << teams
    end
    
    if teams_to_display[0].empty?
      render json: { error: "You have no teams" }, status: 422
    else
      render json: teams_to_display[0], status: 200
    end
  end

  def create
    :authenticate_user!

    team = Team.create(name: params[:name],
                        primary_color: params[:primary_color],
                        secondary_color: params[:secondary_color],
                        user_id: current_user.id)

    if team.persisted?
      players = generate_players(team.id)
      team_and_players = [team, players]
      render json: team_and_players
    else
      render json: { error: team.errors.full_messages }, status: 422
    end
  end

  def update
    :authenticate_user!

    team_to_update = Team.where(id: params[:id])

    if team_to_update[0].user_id != current_user.id
      render json: { error: 'Only authorized to update current users team' }, status: 401
      return
    end

    team_to_update.update(update_params)

    render json: team_to_update[0], status: 200
  end

  def show
    :authenticate_user!
    team = Team.find_by(id: params[:id])
    starting_11 = Player.where(team_id: params[:id], starting_11: true)
    substitutes = Player.where(team_id: params[:id], starting_11: false)
    players = []
    players << starting_11
    players << substitutes
    seasons = team.seasons.last(1)[0]
    team_and_players_seasons = [team, players, seasons]

    render json: team_and_players_seasons
  end


  private
  def update_params
    params.permit(:name, :primary_color, :secondary_color, :id).reject { |_k, v| v.nil? }
  end
end
