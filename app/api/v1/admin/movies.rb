class API::V1::Admin::Movies < Grape::API
  helpers API::V1::Helpers
  namespace :admin do
    resource :movies do
      desc 'Show movies',
           entity: API::Entities::V1::Admin::Movie
      params do
      end
      get do
        movies = Rails.cache.fetch('movies', expires_in: 120.minutes) do
          Movie.includes(:user).all.order(id: :desc)
        end
        present movies, with: API::Entities::V1::Admin::Movie
      end

      desc 'Get movie liked',
           entity: API::Entities::V1::Admin::Movie
      params do
        use :authorization_token
      end
      get '/liked' do
        user = authenticate_user!
        present user.reacted_movies, with: API::Entities::V1::Admin::Movie
      end
    end
  end
end
