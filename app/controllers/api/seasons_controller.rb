# frozen_string_literal: true

class Api::SeasonsController < ApplicationController
  include TeamsCreator

  def create
    :authenticate_user!
    # Create computer teams return user team + computer teams
    #   team_name = team_name_generator(i)

    #   team = Team.create(name: params[:name],
    #               primary_color: params[:primary_color],
    #               secondary_color: params[:secondary_color],
    #               user_id: current_user.id)
    # end
  end
end
