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
end


