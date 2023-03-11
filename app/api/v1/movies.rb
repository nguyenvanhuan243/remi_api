class API::V1::Movies < Grape::API
  helpers API::V1::Helpers
  resource :movies do
    desc 'Show movies',
         entity: API::Entities::V1::Movie
    params do
      optional :title, type: String, desc: 'movie title'
    end
    get do
      movies = Movie.filter(params).order(id: :desc).includes(:likes)
      movie_total_likes = movies.joins(:likes).where('likes.status = 1').group_by { |movie| "#{movie.id}" }
      movie_total_dislikes = movies.joins(:likes).where('likes.status = 0').group_by { |movie| "#{movie.id}" }
      movie_likes = movies.joins(:likes).group_by { |movie| "#{movie.id}" }
      present movies, with: API::Entities::V1::Movie, total_likes: {
        likes: movie_total_likes,
        dislikes: movie_total_dislikes,
        movie_likes: movie_likes
      }
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
      present movie, with: API::Entities::V1::Movie
    end
  end
end
