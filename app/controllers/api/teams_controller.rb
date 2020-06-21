# frozen_string_literal: true

class Api::TeamsController < ApplicationController
  def index
    teams_to_display = []

    if current_user
      teams = Team.where(user_id: current_user.id)
      teams_to_display << teams
    else
      teams = Team.all
      teams_to_display << teams
    end

    render json: teams_to_display[0], status: 200
  end

  def create
    :authenticate_user!

    team = Team.create(name: params[:name],
                       primary_color: params[:primary_color],
                       secondary_color: params[:secondary_color],
                       user_id: current_user.id)

    if team.persisted?
      render json: team
    else
      render json: { error: team.errors.full_messages }, status: 422
    end
  end

  def update
    :authenticate_user!

    team_to_update = Team.where(id: params[:id])

    if team_to_update[0].user_id != current_user.id
      render json: { error: 'Only authorized to update own team' }, status: 401
      return
    end

    team_to_update.update(update_params)

    render json: team_to_update[0], status: 200
  end


  private
  def update_params
    params.permit(:name, :primary_color, :secondary_color).reject { |_k, v| v.nil? }
  end
end
