class API::V1::Movies < Grape::API
  helpers API::V1::Helpers
  resource :movies do
    desc 'Show movies',
         entity: API::Entities::V1::Movie
    params do
      optional :title, type: String, desc: 'movie title'
    end
    get do
      Rails.cache.fetch("movies", expires_in: 120.minutes) do
        movies = Movie.all.order(id: :desc)
        present movies, with: API::Entities::V1::Movie
      end
    end

    desc 'Create a movie',
         entity: API::Entities::V1::Movie
    params do
      use :authorization_token
      optional :url, type: String, desc: 'youtube url'
    end
    post do
      begin
        user = authenticate_user!
        movie = user.movies.create(MovieService.new(params[:url]).video_info)
        error!({ messages: movie.errors.messages }, :unprocessable_entity) if movie.errors.messages.present?
        ActionCable.server.broadcast("movie_channel", {
          title: movie.title,
          user: user.email
        })
        present movie, with: API::Entities::V1::Movie
      rescue
        error!({ messages: "invalid video" }, :bad_request)
      end
    end
  end
end
