require 'rails_helper'

RSpec.describe "Rounds", type: :request do
  describe 'Rounds show call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let(:team) { create(:team, user_id: user.id) }

    before do
      post '/api/seasons', params: { team_id: team.id }, headers: headers
      season = Season.find(response_json[0]['id'])
      season.update(round: 2)
      games_round_1 = Game.where(round: 1)
      games_round_1[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_1[0].home_team_id, result: '1')
      games_round_1[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_1[1].home_team_id, result: '1')
      games_round_1[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_1[2].home_team_id, result: '1')
      games_round_2 = Game.where(round: 2)
      games_round_2[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_2[0].home_team_id, result: '1')
      games_round_2[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_2[1].home_team_id, result: '1')
      games_round_2[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_2[2].home_team_id, result: '1')
      get "/api/rounds/", params: { team_id: team.id, round: 2 }, headers: headers
    end

    it 'returns the games of the round' do
      expect(response_json.length).to eq 3
    end

    it 'with detailed match info' do
      expect(response_json[0].length).to eq 13
    end
  end

  describe 'Rounds update call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let(:team) { create(:team, user_id: user.id) }

    before do
      post '/api/seasons', params: { team_id: team.id }, headers: headers
      season = Season.find(response_json[0]['id'])
      season.update(round: 2)
      games_round_1 = Game.where(round: 1)
      games_round_1[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_1[0].home_team_id, result: '1')
      games_round_1[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_1[1].home_team_id, result: '1')
      games_round_1[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_1[2].home_team_id, result: '1')
      games_round_2 = Game.where(round: 2)
      games_round_2[0].update(goals_ht: 2, goals_at: 1, winner_team_id: games_round_2[0].home_team_id, result: '1')
      games_round_2[1].update(goals_ht: 3, goals_at: 2, winner_team_id: games_round_2[1].home_team_id, result: '1')
      games_round_2[2].update(goals_ht: 4, goals_at: 2, winner_team_id: games_round_2[2].home_team_id, result: '1')
      put "/api/rounds/", params: { season_id: season.id, round: 3 }, headers: headers
    end

    it 'returns the results of the round' do
      expect(response_json.length).to eq 3
    end

    it 'with each games corresponding info' do
      expect(response_json[0].length).to eq 13
    end
  end
end
