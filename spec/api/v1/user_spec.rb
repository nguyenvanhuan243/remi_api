require 'rails_helper'
require 'faker'

RSpec.describe User, type: :request do
  let(:user) do
    FactoryGirl.create(:user)
  end
  # let(:normal_user2) {
  # 	FactoryGirl.create(:user, name: 'Name 2222', email: 'user2222@gmail.com')
  # }
  # let(:admin_user) {
  # 	FactoryGirl.create(:user, email: 'admin@gmail.com', user_type: User::USER_TYPES[:admin])
  # }
  # let(:admin_user2) {
  # 	FactoryGirl.create(:user, id: 99, user_type: User::USER_TYPES[:admin])
  # }
  # describe 'POST /api/v1/users' do
  # 	context 'with valid params' do
  # 		it 'create a new user' do
  # 			post '/api/v1/users', params: {
  # 				name: 'Name',
  # 				password: 'admin1234',
  # 				email: 'user1@gmail.com',
  # 				user_type: User::USER_TYPES[:user]
  # 			}
  # 			body_formatted = JSON.parse(response.body)
  # 			expect(response.code).to eq('201')
  # 			expect(body_formatted['name']).to eq('Name')
  # 			expect(response).to have_http_status(:created)
  # 			expect(body_formatted['email']).to eq('user1@gmail.com')
  # 			expect(body_formatted['user_type']).to eq(User::USER_TYPES.keys[0].to_s)
  # 		end
  # 	end

  # 	context 'Invalid params' do
  # 		user_params = {
  # 			name: Faker::Name.name,
  # 			email: Faker::Internet.email,
  # 			password: Faker::Internet.password,
  # 			user_type: User::USER_TYPES[:user]
  # 		}
  # 		it 'duplicate email' do
  # 			post '/api/v1/users', params: user_params.update(:email => normal_user.email)
  # 			expect(JSON.parse(response.body)['success']).to eq(false)
  # 		end

  # 		it 'name or user_type or email is nil' do
  # 			['name', 'user_type', 'email'].each do |item|
  # 				post '/api/v1/users', params: user_params.update(item.to_sym => nil)
  # 				expect(JSON.parse(response.body)['success']).to eq(false)
  # 			end
  # 		end

  # 	end
  # end

  describe 'POST /api/v1/users/sign_in' do
    context 'valid params' do
      it 'with valid data' do
        post '/api/v1/users/sign_in', params: { email: user.email, password: '123456' }
        expect(response).to be_success
        expect(JSON.parse(response.body)['access_token']).present?
      end
    end

    context 'wrong params' do
      it 'wrong password' do
        post '/api/v1/users/sign_in', params: { email: user.email, password: 'admin12345666' }
        expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
      end
    end

    # 	it 'wrong email' do
    # 		post '/api/v1/users/sign_in', params: { email: '1111@gmail.com', password: 'admin1234' }
    # 		expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
    # 	end

    # 	it 'wrong email and password' do
    # 		post '/api/v1/users/sign_in', params: { email: '1111@gmail.com', password: '1111' }
    # 		expect(JSON.parse(response.body)['error']).to eq('Your email or password not correct')
    # 	end
    # end
  end

  # describe 'GET api/v1/users' do
  # 	context 'invalid json web token' do
  # 		it 'is blank' do
  # 			['', nil, 'errortoken'].each do |item|
  # 				get '/api/v1/users', params: {}, headers: { Authorization: item }
  # 				expect(JSON.parse(response.body)['error']).to eq('Invalid json web token')
  # 			end
  # 		end
  # 	end

  # 	context 'valid json web token' do
  # 		it 'is normal user' do
  # 			post '/api/v1/users/sign_in', params: { email: normal_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			get '/api/v1/users', params: {  per_page: 1, page: 1 }, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('Just admin can get user list')
  # 		end

  # 		it 'is admin user' do
  # 			normal_user
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			get '/api/v1/users', params: {  per_page: 1, page: 1 }, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['users'].count).to eq(1)
  # 		end
  # 	end
  # end

  # describe 'GET api/v1/users/search' do
  # 	context 'user search' do
  # 		it 'normal user search' do
  # 			post '/api/v1/users/sign_in', params: { email: normal_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			get '/api/v1/users/search', params: { email: nil, name: nil
  # 			}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('Just admin can search users')
  # 		end
  # 	end

  # 	context 'admin user search' do
  # 		it 'admin user search' do
  # 			normal_user
  # 			normal_user2
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			get '/api/v1/users/search', params: {
  # 				email: 'user@gmail.com',
  # 				name: 'Name'
  # 			}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body).count).to eq(2)
  # 		end
  # 	end
  # end

  # describe 'DELETE api/v1/users/id' do
  # 	context 'normal user delete user' do
  # 		it 'normal user delete' do
  # 			post '/api/v1/users/sign_in', params: { email: normal_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			delete '/api/v1/users/id', params: { id: normal_user.id }, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('Just admin can delete user')
  # 		end
  # 	end

  # 	context 'admin delete user' do
  # 		it 'can delete user' do
  # 			normal_user
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			delete "/api/v1/users/#{100}", params: {}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('User has been deleted')
  # 		end

  # 		it 'user not found' do
  # 			normal_user
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			delete "/api/v1/users/#{10000}", params: {}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('User Not Found')
  # 		end

  # 		it 'Can not delete admin user' do
  # 			admin_user2
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			delete "/api/v1/users/#{99}", params: {}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq("Can't delete admin user")
  # 		end
  # 	end
  # end

  # describe 'PUT api/v1/users/id' do
  # 	context 'normal user edit user' do
  # 		it 'normal user edit' do
  # 			post '/api/v1/users/sign_in', params: { email: normal_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			put "/api/v1/users/#{normal_user.id}", params: {}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('Just admin can update user')
  # 		end
  # 	end

  # 	context 'admin edit user' do
  # 		it 'edit admin user' do
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			put "/api/v1/users/#{admin_user2.id}", params: {}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['message']).to eq('Can not edit admin user')
  # 		end

  # 		it 'edit normal user' do
  # 			post '/api/v1/users/sign_in', params: { email: admin_user.email, password: 'admin1234' }
  # 			token = JSON.parse(response.body)['access_token']
  # 			put "/api/v1/users/#{normal_user.id}", params: {
  # 				name: 'Name updated',
  # 				user_type: User::USER_TYPES[:user]
  # 			}, headers: { Authorization: token }
  # 			expect(JSON.parse(response.body)['name']).to eq('Name updated')
  # 			expect(JSON.parse(response.body)['user_type']).to eq(User::USER_TYPES[:user])
  # 		end
  # 	end
  # end
end
