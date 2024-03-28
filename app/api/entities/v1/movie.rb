module API::Entities::V1
  class Movie < API::Entities::V1::Base
    expose :id, documentation: { type: 'Integer', desc: 'Movie ID' }
    expose :title, documentation: { type: 'String', desc: 'Movie Title.' }
    expose :description, documentation: { type: 'String', desc: 'Movie Description' }
    expose :shared_by, documentation: { type: 'String', desc: 'Movie Description' }
    expose :embed_url, documentation: { type: 'String', desc: 'Movie Description' }
    expose :total_likes do |movie, options|
      options[:total_likes] && options[:total_likes][:likes]["#{movie.id}"]&.size.to_i
    end
    expose :total_dislikes do |movie, options|
      options[:total_likes] && options[:total_likes][:dislikes]["#{movie.id}"]&.size.to_i
    end
    expose :like_list, using: API::Entities::V1::Like do |movie, options|
      options[:total_likes] && options[:total_likes][:all_likes]["#{movie.id}"] || []
    end
  end
end
