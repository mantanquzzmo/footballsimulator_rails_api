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

    it 'presents three teams to the user' do
      expect(response_json[0].length).to eq 10
    end
  end
end
