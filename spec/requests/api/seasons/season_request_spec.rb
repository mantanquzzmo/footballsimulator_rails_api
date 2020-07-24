# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons', type: :request do
  describe 'Seasons create call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let(:team) { create(:team, user_id: user.id) }

    before do
      post '/api/seasons', params: { team_id: team.id }, headers: headers
    end

    it 'presents the teams and the schedule' do
      expect(response_json.length).to eq 3
    end

    it 'schedule should have 5 rounds' do
      expect(response_json[2].length).to eq 5
    end

    it 'teams should be 6' do
      expect(response_json[1].length).to eq 6
    end

    it 'season details to be presented' do
      expect(response_json[0].length).to eq 9
    end

    it '5 teams should have same computer_id' do
      expect(response_json[1][1]["user_id"]).to eq response_json[1][2]["user_id"]
    end

    it 'User team should be presented first' do
      expect(response_json[1][0]["user_id"]).not_to eq response_json[1][2]["user_id"]
    end
  end
end
