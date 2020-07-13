# frozen_string_literal: true

RSpec.describe 'GET /api/teams/:id', type: :request do

  include PlayersCreator
  
  describe 'Teams show call' do
    let(:user) { create(:user) }
    let(:team) { create(:team, user_id: user.id) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'index action for teams controller' do
      before do
        generate_players(team.id)
        get "/api/teams/#{team.id}", headers: headers
      end

      it 'presents team info to user' do
        expect(response_json[0]["name"]).to eq "Gremio"
      end

      it 'as well as team info' do
        expect(response_json[0].length).to eq 7
      end

      it 'presents player info to user' do
        expect(response_json[1].length).to eq 20
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end
    end
  end
end
