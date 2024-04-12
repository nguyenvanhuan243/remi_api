class API::V1::Movies < Grape::API
  helpers API::V1::Helpers
  resource :movies do
    desc 'Show movies',
         entity: API::Entities::V1::Movie
    params do
    end
    get do
      movies = Rails.cache.fetch('movies', expires_in: 120.minutes) do
        Movie.includes(:user).all.order(id: :desc)
      end
      present movies, with: API::Entities::V1::Movie
    end

    desc 'Get movie liked',
         entity: API::Entities::V1::Movie
    params do
      use :authorization_token
    end
    get "/liked" do
      user = authenticate_user!
      present user.reacted_movies, with: API::Entities::V1::Movie
    end

    desc 'Check user liked movie',
         entity: API::Entities::V1::Movie
    params do
    end
    get ':id/check-user-like' do
      present movies, with: API::Entities::V1::Movie
    end

    desc 'Create a movie',
         entity: API::Entities::V1::Movie
    params do
      use :authorization_token
      optional :url, type: String, desc: 'youtube url'
    end
    post do
      user = authenticate_user!
      movie = user.movies.create(MovieService.new(params[:url]).video_info)
      error!({ messages: movie.errors.messages }, :unprocessable_entity) if movie.errors.messages.present?
      Remitano::BroadcastMovieWorker.perform_async(movie.id)
      # Remitano::BroadcastMovieWorker.new.perform(movie.id)
      present movie, with: API::Entities::V1::Movie
    rescue StandardError
      error!({ messages: 'invalid video' }, :bad_request)
    end
  end
end
