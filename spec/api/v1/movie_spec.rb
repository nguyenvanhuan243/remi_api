# require 'rails_helper'
# require 'faker'

# RSpec.describe Movie, type: :request do
#   before do
#     @user = FactoryGirl.create(:user)
#     @movie = FactoryGirl.create(:movie, user_id: @user.id, title: 'Movie Title')
#   end

#   # Get movie list
#   describe 'GET api/v1/movies' do
#     it 'get movies' do
#       get '/api/v1/movies'
#       expect(JSON.parse(response.body).count).to eq(Movie.count)
#     end
#   end

#   # Get movie list by title
#   describe 'GET api/v1/movies' do
#     it 'get movies with title not found' do
#       get '/api/v1/movies', params: { title: "Not Found" }
#       expect(JSON.parse(response.body).count).to eq(0)
#     end

#     it 'get movies with title OK' do
#       get '/api/v1/movies', params: { title: "Title" }
#       expect(JSON.parse(response.body).count).to eq(Movie.count)
#     end

#     it 'get movies with title OK' do
#       get '/api/v1/movies', params: { title: "Movie Title" }
#       expect(JSON.parse(response.body).count).to eq(Movie.count)
#     end

#     it 'get movies with title OK' do
#       get '/api/v1/movies', params: { title: "Movie" }
#       expect(JSON.parse(response.body).count).to eq(Movie.count)
#     end
#   end

#   # Create a movie
#   describe 'POST /api/v1/movies' do
#     context 'valid params' do
#       it 'with valid data' do
#         post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
#         expect(response).to be_success
#         expect(JSON.parse(response.body)['access_token']).present?
#         post '/api/v1/movies', params: { 'url': 'https://www.youtube.com/watch?v=TsdloLSpk5A' }, headers: { Authorization: JSON.parse(response.body)['access_token'] }
#         expect(JSON.parse(response.body)['title']).to eq("Homemade chiron bugatti experience.  Try bugatti's music system")
#       end
#     end
#   end
# end
