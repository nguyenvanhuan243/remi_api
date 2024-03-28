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
      ActionCable.server.broadcast("movie_channel", "Create new video")
      likes = movies.joins(:likes).where("likes.status = #{Like.statuses[:like]}").group_by { |movie| "#{movie.id}" }
      dislikes = movies.joins(:likes).where("likes.status = #{Like.statuses[:dislike]}").group_by { |movie| "#{movie.id}" }
      all_likes = Like.all.group_by { |like| "#{like.movie_id}" }
      present movies, with: API::Entities::V1::Movie, total_likes: {
        likes: likes,
        dislikes: dislikes,
        all_likes: all_likes
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
      ActionCable.server.broadcast("movie:4", "Hello")
      error!({ messages: movie.errors.messages }, :unprocessable_entity) if movie.errors.messages.present?
      present movie, with: API::Entities::V1::Movie
    end
  end
end
