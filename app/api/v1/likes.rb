class API::V1::Likes < Grape::API
  helpers API::V1::Helpers
  resource :likes do

    desc 'Count like by movie id',
      entity: API::Entities::V1::Like
    get '/movies/:id/likes' do
      movie = Movie.find_by(id: params[:id])
      { total_likes: movie.likes.likes.count }
    end

    desc 'Count dislike by movie id',
      entity: API::Entities::V1::Like
    get '/movies/:id/dislikes' do
      movie = Movie.find_by(id: params[:id])
      { total_dislikes: movie.likes.dislikes.count }
    end

    desc 'Like or Dislike movie',
      entity: API::Entities::V1::Like
    params do
      use :authorization_token
    end
    post '/movies/:id' do
      user = authenticate_user!
      movie = Movie.find_by(id: params[:id])
      error!("Movie Not Found with id #{params[:id]}", 404) if movie.nil?
      user_like = movie.likes.find_by(user_id: user.id)
      if user_like.nil?
        movie.likes.create(user_id: user.id, status: params[:status])
      else
        movie.likes.update(user_id: user.id, status: params[:status])
      end
      present user_like.status
    end
  end
end