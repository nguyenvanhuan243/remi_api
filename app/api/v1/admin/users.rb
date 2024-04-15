class API::V1::Admin::Users < Grape::API
  helpers API::V1::Helpers

  namespace :admin do
    resource :users do
      desc 'Get user list',
           entity: API::Entities::V1::User
      params do
      end
      get do
        if params[:user_type] == "admin"
          return present User.admin.all, with: API::Entities::V1::User
        end
        present User.normal.all, with: API::Entities::V1::User
      end

      desc 'Get one user',
           entity: API::Entities::V1::User
      params do
        use :authorization_token
      end
      get :me do
        user = authenticate_user!
        present user, with: API::Entities::V1::User
      end

      desc 'Sign in',
           entity: API::Entities::V1::User
      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post :sign_in do
        user = User.admin.find_by(email: params[:email], password: Digest::MD5.hexdigest(params[:password]))
        error!('Your email or password not correct', 400) if user.nil?
        present access_token: 'Bearer ' + Authenticate.issue({ user_id: user.id })
      end

      desc 'Delete a user',
        entity: API::Entities::V1::User
      params do
        use :authorization_token
        requires :id, type: Integer, desc: 'User ID'
      end
      delete ':id' do
        authenticate_admin!
        user = User.find_by(id: params[:id])
        error!('User not found', 404) if user.nil?

        if user&.destroy
          present message: 'User deleted successfully'
        else
          error!('Can not delete this user', 400)
        end
      end
    end
  end
end
