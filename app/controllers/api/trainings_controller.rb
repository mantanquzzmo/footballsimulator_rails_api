# frozen_string_literal: true

class Api::TrainingsController < ApplicationController
  include PlayersTraining

  def create
    :authenticate_user!

    player = Player.find(params[:player_id])
    team = Team.find(player.team_id)

    if team.user_id != current_user.id
      render json: { error: 'Only authorized to train your own players' }, status: 401
    elsif team.balance < 15
      render json: { error: 'Your teams balance is to low' }, status: 412
    else
      training = player_training(player)

      training_session = Training.create(player_id: player.id,
                                         form_before: player.form,
                                         form_after: training[0],
                                         form_tendency_before: player.form_tendency,
                                         form_tendency_after: training[1])

      if training_session.persisted?
        player.update(form: training_session.form_after, form_tendency: training_session.form_tendency_after)
        balance = team.balance
        balance -= 15
        team.update(balance: balance)
        render json: [player.name, training_session], status: 200
      else
        render json: { error: 'Something went wrong' }, status: 401
      end
    end
  end


end
