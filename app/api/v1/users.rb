class API::V1::Users < Grape::API
  helpers API::V1::Helpers

  resource :users do
    desc 'Show user list',
         entity: API::Entities::V1::User
    params do
    end
    get do
      present User.all, with: API::Entities::V1::User
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

    desc 'Verify User Email',
         entity: API::Entities::V1::User
    params do
      requires :email, type: String, desc: 'User email'
    end
    get :checking_email do
      email_service = EmailVerifyService.new(params[:email], 'power')
      present email_service.valid
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
      if @user.save
        present @user, with: API::Entities::V1::User
      else
        error!({ messages: @user.errors.messages }, :unprocessable_entity)
      end
    rescue Exception => e
      error!({ messages: e }, 400)
    end

    desc 'Change Password',
         entity: API::Entities::V1::User
    params do
      use :authorization_token
      requires :current_password, type: String, desc: 'Current Password'
      requires :new_password, type: String, desc: 'New Password'
      requires :confirm_password, type: String, desc: 'Confirm New Password'
    end
    post :change_password do
      user = authenticate_user!
      if Digest::MD5.hexdigest(params[:current_password]) == user.password && (params[:new_password] == params[:confirm_password] && user.update_attributes(password: Digest::MD5.hexdigest(params[:new_password])))
        return { success: true,
                 message: 'Password has been changed' }
      end
      { success: false, message: 'Password has not been changed' }
    end
  end
end
