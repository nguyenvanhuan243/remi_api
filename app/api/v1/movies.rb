class API::V1::Movies < Grape::API
  helpers API::V1::Helpers
  resource :movies do
    desc 'Show movies',
         entity: API::Entities::V1::Movie
    params do
      optional :title, type: String, desc: 'movie title'
    end
    get do
      if params[:title].present?
        return present Movie.filter_by_title(params[:title]).order('id DESC'),
                       with: API::Entities::V1::Movie
      end

      present Movie.order('id DESC'), with: API::Entities::V1::Movie
    end

    desc 'Create a movie',
         entity: API::Entities::V1::Movie
    params do
      use :authorization_token
      optional :url, type: String, desc: 'youtube url'
    end
    post do
      user = authenticate_user!
      movie_params = MovieService.new(params[:url]).get_video_info
      movie = user.movies.create(movie_params)
      error!({ messages: movie.errors.messages }, :unprocessable_entity) if movie.errors.messages.present?
      present movie, with: API::Entities::V1::Movie
    end
  end
end
