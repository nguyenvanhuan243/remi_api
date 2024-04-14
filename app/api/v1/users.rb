class API::V1::Users < Grape::API
  helpers API::V1::Helpers

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
      user = User.find_by(email: params[:email], password: Digest::MD5.hexdigest(params[:password]))
      error!('Your email or password not correct', 400) if user.nil?
      present access_token: 'Bearer ' + Authenticate.issue({ user_id: user.id })
    end

    desc 'Create a new user',
         entity: API::Entities::V1::User
    params do
      requires :email, type: String, desc: 'User email'
      requires :password, type: String, desc: 'User password'
    end
    post do
      error!({ messages: 'Password min 6 characters' }, 422) if params[:password].length < 6
      params[:password] = Digest::MD5.hexdigest params[:password]
      @user = User.new(params)
      return present @user, with: API::Entities::V1::User if @user.save

      error!({ messages: @user.errors.messages }, :unprocessable_entity)

    rescue Exception => e
      error!({ messages: e }, 400)
    end

    desc 'Get user assets by token',
      entity: API::Entities::V1::UserAsset
    params do
      use :authorization_token
    end
    get '/assets' do
      user = authenticate_user!
      present user.assets, with: API::Entities::V1::UserAsset
    end
  end
end
