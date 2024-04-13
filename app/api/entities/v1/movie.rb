module API::Entities::V1
  class Movie < API::Entities::V1::Base
    expose :id, documentation: { type: 'Integer', desc: 'Movie ID' }
    expose :title, documentation: { type: 'String', desc: 'Movie Title.' }
    expose :description, documentation: { type: 'String', desc: 'Movie Description' }
    expose :shared_by, documentation: { type: 'String', desc: 'Movie Description' }
    expose :embed_url, documentation: { type: 'String', desc: 'Movie Description' }
    expose :liked_user_ids, documentation: { desc: 'Movie Description' }

    def liked_user_ids
      object.reacted_users.pluck(:id)
    end
  end
end
