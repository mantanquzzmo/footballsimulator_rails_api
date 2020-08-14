# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Seasons', type: :request do
  describe 'Seasons show call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    before do
      post '/api/teams', params: { name: 'Gremio',
                                   primary_color: 'teal' }, headers: headers
      post '/api/seasons', params: { team_id: response_json[0]['id'] }, headers: headers
      season = Season.find(response_json[0]['id'])
      (0..season.total_rounds).each do |round|
        put '/api/rounds/', params: { season_id: season.id, round: round + 1 }, headers: headers
      end
      put "/api/seasons/#{season['id']}", headers: headers
    end

    it 'return the current standing' do
      binding.pry
      expect(response_json.length).to eq 6
    end

    it 'with detailed info' do
      expect(response_json[0].length).to eq 10
    end
  end
end
