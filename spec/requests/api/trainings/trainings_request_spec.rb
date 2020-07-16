# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainings', type: :request do
  describe 'Players show call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
    let!(:team) { create(:team) }
    let!(:player) { create(:player, team_id: team.id) }

    describe 'show action for players controller' do

      before do
        post "/api/trainings", params: { player_id: "#{player.id}"}, headers: headers
      end

      it 'and returns a 200 response status' do
        binding.pry
        expect(response).to have_http_status 200
      end
    end
  end
end
