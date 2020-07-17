# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Players', type: :request do
  describe 'Players show call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'show action for players controller' do

      before do
        post '/api/teams', params: { name: 'Gremio',
                                    primary_color: 'teal' }, headers: headers
        players = Player.all
        player = players[0]
        get "/api/players/#{player.id}"
      end

      it 'presents three teams to the user' do
        expect(response_json[0].length).to eq 10
      end


      it 'presents the players attributes' do
        players = Player.all
        expect(response_json[0]["skill"]).to eq players[0].skill
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end
    end
  end
end
