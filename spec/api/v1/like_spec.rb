require 'rails_helper'
require 'faker'

RSpec.describe Like, type: :request do
  before do
    @user = FactoryGirl.create(:user)
    @movie = FactoryGirl.create(:movie, user_id: @user.id, title: 'Movie Title')
    @like = FactoryGirl.create(:like, user_id: @user.id, movie_id: @movie.id, status: 1)
  end

  # Like movie
  describe 'POST api/v1/likes/movies/:id' do
    context 'valid params' do
      it 'with valid data' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
        post "/api/v1/likes/movies/#{@movie.id}", params: { 'status': 1 },
                                                  headers: { Authorization: JSON.parse(response.body)['access_token'] }
        expect(JSON.parse(response.body)).to eq('like')
      end
    end
  end

  # DisLike movie
  describe 'POST api/v1/likes/movies/:id' do
    context 'valid params' do
      it 'with valid data' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
        post "/api/v1/likes/movies/#{@movie.id}", params: { 'status': 0 },
                                                  headers: { Authorization: JSON.parse(response.body)['access_token'] }
        expect(JSON.parse(response.body)).to eq('dislike')
      end
    end
  end

  # Count like a movie
  describe 'GET api/v1/likes/movies/10/likes' do
    context 'valid params' do
      it 'with valid data' do
        get "/api/v1/likes/movies/#{@movie.id}/likes"
        expect(JSON.parse(response.body)['total_likes']).to eq(1)
      end
    end
  end

  # Count dislike a movie
  describe 'GET api/v1/likes/movies/10/dislikes' do
    context 'valid params' do
      it 'with valid data' do
        get "/api/v1/likes/movies/#{@movie.id}/dislikes"
        expect(JSON.parse(response.body)['total_dislikes']).to eq(0)
      end
    end
  end
end
