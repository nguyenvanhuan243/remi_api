require 'rails_helper'
require 'faker'

RSpec.describe User, type: :request do
  before do
    @user = FactoryGirl.create(:user)
  end

  # Create users
  describe 'POST /api/v1/users' do
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
      end
    end
  end
end
