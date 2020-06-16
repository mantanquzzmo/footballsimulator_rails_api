class Api::TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, status: 200
  end
end


