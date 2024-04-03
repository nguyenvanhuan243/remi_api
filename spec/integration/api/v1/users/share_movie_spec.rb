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
      youtube_url = "https://www.youtube.com/watch?v=8XECUoTyQrI&t=46s"
      post '/api/v1/movies', params: { 'url': youtube_url }, headers: { Authorization: access_token }
      expect(JSON.parse(response.body)['title']).to eq("Connect To Action Cable From External Applications | Ruby On Rails 7 Websockets Tutorial")
      expect(JSON.parse(response.body)['shared_by']).to eq(@user.email)

      # get movies
      get '/api/v1/movies'
      expect(JSON.parse(response.body).count).to eq(Movie.count)
    end
  end
end
