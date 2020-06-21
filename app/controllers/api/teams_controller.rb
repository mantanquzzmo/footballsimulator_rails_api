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
end
