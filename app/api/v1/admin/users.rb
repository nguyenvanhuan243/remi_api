class API::V1::Admin::Users < Grape::API
  helpers API::V1::Helpers

  namespace :admin do
    resource :users do
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
    end
  end
end