class Api::TeamsController < ApplicationController
  def index
    binding.pry
    teams = Team.all
    render json: teams, status: 200


  end
end


