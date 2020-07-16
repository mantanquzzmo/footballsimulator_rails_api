# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainings', type: :request do
  describe 'Training create call' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let!(:team) { create(:team, user_id: user.id) }
    let!(:player) { create(:player, team_id: team.id) }
    let!(:team2) { create(:team, user_id: user.id, balance: 0) }
    let!(:player2) { create(:player, team_id: team2.id) }
    let!(:team3) { create(:team, user_id: user2.id) }
    let!(:player3) { create(:player, team_id: team3.id) }

    describe 'create action for trainings controller' do
      before do
        post "/api/trainings", params: { player_id: "#{player.id}"}, headers: headers
      end

      it 'returns info and a 200 response status' do
        expect(response_json.length).to eq 2
        expect(response_json[1].length).to eq 8
        expect(response).to have_http_status 200
      end
    end

    describe 'create action with low balance' do
      before do
        post "/api/trainings", params: { player_id: "#{player2.id}"}, headers: headers
      end

      it 'returns an error message' do
        expect(response_json["error"]).to eq "Your teams balance is to low"
      end
    end

    describe 'create action with other teams players' do
      before do
        post "/api/trainings", params: { player_id: "#{player3.id}"}, headers: headers
      end

      it 'returns an error message' do
        binding.pry
        expect(response_json["error"]).to eq "Only authorized to train your own players"
      end
    end
  end
end
