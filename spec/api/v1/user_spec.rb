require 'rails_helper'
require 'faker'

RSpec.describe User, type: :request do
  before do
    @user = FactoryGirl.create(:user)
  end

  # sign in user
  describe 'POST /api/v1/users/sign_in' do
    context 'valid params' do
      it 'with valid data' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
      end
    end

    context 'wrong params' do
      it 'wrong password' do
        post '/api/v1/users/sign_in', params: { email: @user.email, password: 'admin12345666' }
        expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
      end
      it 'wrong email' do
        post '/api/v1/users/sign_in', params: { email: 'bitcoin@bitcointrading.comn', password: '123456' }
        expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
      end
      it 'email and password are wrong' do
        post '/api/v1/users/sign_in', params: { email: 'bitcoin@bitcointrading.comn', password: '1234564XDDD' }
        expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
      end
    end
  end

  # Create users
  describe 'POST /api/v1/users' do
    context 'Valid params' do
      it 'Valid params' do
        post '/api/v1/users', params: { email: 'new_user@gmail.com', password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['email']).to eq('new_user@gmail.com')
      end
    end

    context 'Ivalid params' do
      it 'duplicate email' do
        post '/api/v1/users', params: { email: @user.email, password: '123456' }
        expect(JSON.parse(response.body)['messages']['email'].first).to eq('has already been taken')
      end

      it 'invalid email' do
        post '/api/v1/users', params: { email: 'email_invalid', password: '123456' }
        expect(JSON.parse(response.body)['messages']['email'].first).to eq('is invalid')
      end

      it 'invalid password' do
        post '/api/v1/users', params: { email: 'email_invalid@gmail.com', password: '123' }
        expect(JSON.parse(response.body)['messages']).to eq('Password min 6 characters')
        expect(response.status).to eq(422)
        expect(response.message).to eq('Unprocessable Entity')
      end
    end
  end

  # Get user by access token
  describe 'GET api/v1/users/me' do
    it 'get user by access token' do
      post '/api/v1/users/sign_in', params: { email: @user.email, password: '123456' }
      get '/api/v1/users/me', params: {}, headers: { Authorization: JSON.parse(response.body)['access_token'] }
      expect(response).to be_success
      expect(JSON.parse(response.body)['email']).to eq(@user.email)
    end
  end
end
