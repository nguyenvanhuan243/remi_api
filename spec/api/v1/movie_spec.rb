require 'rails_helper'
require 'faker'

RSpec.describe Movie, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @movie = FactoryGirl.create(:movie, user_id: @user.id, title: 'Movie Title')
  end

  describe 'POST /api/v1/movies' do
    context 'valid params' do
      it 'with valid data' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
        post '/api/v1/movies', params: { 'url': 'https://www.youtube.com/watch?v=aKKMHadj2iQ' }, headers: { Authorization: JSON.parse(response.body)['access_token'] }
        expect(JSON.parse(response.body)['title']).to eq('Bitcoin and Crypto Holders... Prepare For What Is Coming!')
      end
    end

    context 'invalid params' do
      it 'with invalid youtube url' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
        post '/api/v1/movies', params: { 'url': 'https://www.youtube.com/watch?v=aKKMHa' }, headers: { Authorization: JSON.parse(response.body)['access_token'] }
        expect(response).to be_a_bad_request
      end
    end
  end
end
