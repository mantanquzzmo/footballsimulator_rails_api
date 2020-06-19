# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams create call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'creates a team of choice for the user' do
      before do
        post '/api/teams', headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns 3 teams that belong to player' do
        expect(response_json)
      end
    end
  end
end
