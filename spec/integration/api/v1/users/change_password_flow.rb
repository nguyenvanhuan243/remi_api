require 'rails_helper'
require 'faker'

RSpec.describe User, type: :request do

  # Change password flow
  describe 'POST /api/v1/users/change_password' do
    context 'Valid params' do
      it 'Valid params' do
        # Sign up user
        post '/api/v1/users', params: { email: 'new_user@gmail.com', password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['email']).to eq('new_user@gmail.com')

        # Sign in user
        post '/api/v1/users/sign_in', params: { email: 'new_user@gmail.com', password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?

        # Change password
        post '/api/v1/users/sign_in', params: { email: 'new_user@gmail.com', password: '123456' }
        post '/api/v1/users/change_password',
             params: { current_password: '123456', new_password: '654321', confirm_password: '654321' }, headers: { Authorization: JSON.parse(response.body)['access_token'] }
        expect(response).to be_success
        expect(JSON.parse(response.body)['success']).to eq(true)
        expect(JSON.parse(response.body)['message']).to eq('Password has been changed')

         # Sign in again
         post '/api/v1/users/sign_in', params: { email: 'new_user@gmail.com', password: '654321' }
         expect(response).to be_success
         expect(JSON.parse(response.body)['access_token']).present?
      end
    end
  end
end
