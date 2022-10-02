require 'rails_helper'
require 'faker'

RSpec.describe Movie, type: :request do
  before do
    @user = FactoryGirl.create(:user)
  end

  # Share movie flow
  describe 'POST /api/v1/movies' do
    it 'share movie flow' do
      # Sign in user
      post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
      access_token = JSON.parse(response.body)['access_token']
      expect(response).to be_success
      expect(access_token).present?

      # Share movie
      youtube_url = 'https://www.youtube.com/watch?v=LGX3W_SUWEw'
      post '/api/v1/movies', params: { 'url': youtube_url }, headers: { Authorization: access_token }
      title = 'Trend TikTok I Trào Lưu Có Đâu Ai Ngờ Một Ngày Tình Cờ Như Giấc Mơ ...I Có Ai Đâu Ngờ Remix'
      expect(JSON.parse(response.body)['title']).to eq(title)
      expect(JSON.parse(response.body)['shared_by']).to eq(@user.email)
      expect(JSON.parse(response.body)['total_likes']).to eq(0)
      expect(JSON.parse(response.body)['total_dislikes']).to eq(0)

      # get movies
      get '/api/v1/movies', params: { title: 'Trend TikTok' }
      expect(JSON.parse(response.body).count).to eq(1)
      expect(JSON.parse(response.body).first['title']).to eq(title)
      movie_id = JSON.parse(response.body).first['id']

      # Like movie
      post "/api/v1/likes/movies/#{movie_id}", params: { status: 1 }, headers: { Authorization: access_token }
      expect(JSON.parse(response.body)).to eq('like')

      # Dislike movie
      post "/api/v1/likes/movies/#{movie_id}", params: { status: 0 }, headers: { Authorization: access_token }
      expect(JSON.parse(response.body)).to eq('dislike')
    end
  end
end
