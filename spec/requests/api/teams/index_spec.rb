# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams index call' do
    let!(:team) { create_list(:team, 3, user_id: user.id) }
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'index action for teams controller' do
      before do
        get '/api/teams'
      end

      it 'presents three teams to the user' do
        expect(response_json.length).to eq 3
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end
    end

    describe 'list teams belonging to that user' do
      before do
        get '/api/teams', headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns 3 teams that belong to player' do
        expect(response_json.length).to eq 3
      end
    end
  end
end
