# frozen_string_literal: true

RSpec.describe 'GET /api/teams', type: :request do
  describe 'Teams create call' do
    let(:user) { create(:user) }
    let(:credentials) { user.create_new_auth_token }
    let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

    describe 'Succesfully creates a team of choice for the user' do
      before do
        post '/api/teams', params: { name: 'Gremio',
                                     primary_color: 'teal' }, headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'and returns info about the team' do
        expect(response_json['name']).to eq 'Gremio'
      end

      it 'and returns info about the team' do
        expect(response_json.length).to eq 7
      end
    end

    describe 'Unsuccesfully creates a team of choice for the user' do
      before do
        post '/api/teams', params: { name: 'Gremio' }, headers: headers
      end

      it 'and returns a 200 response status' do
        expect(response).to have_http_status 422
      end
    end

  end
end
