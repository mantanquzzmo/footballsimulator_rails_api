# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams index call' do
      let!(:team) { create_list(:team, 3) }

    it 'succesfully presents the teams to the user' do
      get '/api/teams'

      expect(response_json.length).to eq 3
    end
  end
end
