class API::V1::Reactions < Grape::API
  helpers API::V1::Helpers

  resource :reactions do
    desc 'Like movie',
         entity: API::Entities::V1::Reaction
    params do
      use :authorization_token
      requires :movie_id, type: Integer, desc: 'movie id'
      requires :reaction_type, type: Integer, desc: 'reaction type'
    end
    post do
      user = authenticate_user!
      react_movie = user.reactions.create!(
        movie_id: params[:movie_id],
        reaction_type: params[:reaction_type]
      )
      present react_movie, with: API::Entities::V1::Reaction
    rescue Exception => e
      error!({ messages: e }, 400)
    end
  end
end
