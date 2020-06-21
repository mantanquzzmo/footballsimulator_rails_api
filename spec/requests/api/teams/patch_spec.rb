# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams patch call' do
    let(:user) { create(:user) }
    let(:team) { create(:team, user_id: user.id) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'Succesfully updates attributes of team' do
      before do
        patch "/api/teams/#{team.id}", params: { name: 'Gremio',
                                     primary_color: 'red' }, headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns updated info' do
        expect(response_json['primary_color']).to eq 'red'
      end

      it 'together will all the info about the team' do
        expect(response_json.length).to eq 7
      end
    end
  end
end
