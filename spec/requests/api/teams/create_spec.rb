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
        expect(response_json[0]['name']).to eq 'Gremio'
      end

      it 'and returns info about the team' do
        expect(response_json[0].length).to eq 9
      end

      it 'and returns info about the players' do  
        expect(response_json[1][0]['position']).to eq 'G'
      end
    end

    describe 'fails because of no primary color' do
      before do
        post '/api/teams', params: { name: 'Gremio' }, headers: headers
      end

      it 'and returns a 422 response status' do
        expect(response).to have_http_status 422
      end
    end
  end
end
