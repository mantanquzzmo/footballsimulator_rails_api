# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams' do
    let(:team) { create(:team) }
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    it 'are presented to the user' do
      get '/api/teams'

      expect(response_json.count).to eq 3
    end
  end
end

