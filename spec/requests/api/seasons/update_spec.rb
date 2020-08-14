# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons', type: :request do
  describe 'Seasons show call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let(:team) { create(:team, user_id: user.id) }

    before do
      post '/api/seasons', params: { team_id: team.id }, headers: headers
      season = Season.find(response_json[0]['id'])
      season.update(round: 5)
      games_round_1 = Game.where(round: 1)
      games_round_1[0].update(goals_ht: 6, goals_at: 1, winner_team_id: games_round_1[0].home_team_id, result: '1')
      games_round_1[1].update(goals_ht: 2, goals_at: 3, winner_team_id: games_round_1[1].home_team_id, result: '1')
      games_round_1[2].update(goals_ht: 2, goals_at: 2, winner_team_id: games_round_1[2].home_team_id, result: '1')
      games_round_2 = Game.where(round: 2)
      games_round_2[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_2[0].home_team_id, result: '1')
      games_round_2[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_2[1].home_team_id, result: '1')
      games_round_2[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_2[2].home_team_id, result: '1')
      games_round_3 = Game.where(round: 3)
      games_round_3[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_3[0].home_team_id, result: '1')
      games_round_3[1].update(goals_ht: 6, goals_at: 2, winner_team_id: games_round_3[1].home_team_id, result: '1')
      games_round_3[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_3[2].home_team_id, result: '1')
      games_round_4 = Game.where(round: 4)
      games_round_4[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_4[0].home_team_id, result: '1')
      games_round_4[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_4[1].home_team_id, result: '1')
      games_round_4[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_4[2].home_team_id, result: '1')
      games_round_5 = Game.where(round: 5)
      games_round_5[0].update(goals_ht: 0, goals_at: 1, winner_team_id: games_round_5[0].home_team_id, result: '1')
      games_round_5[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_5[1].home_team_id, result: '1')
      games_round_5[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_5[2].home_team_id, result: '1')
      put "/api/seasons/#{season['id']}", headers: headers
    end

    it 'return the current standing' do
      expect(response_json.length).to eq 6
    end

    it 'with detailed info' do
      expect(response_json[0].length).to eq 10
    end
  end
end
