module API::Entities::V1
  class Reaction < API::Entities::V1::Base
    expose :id, documentation: { type: 'Integer', desc: 'Id of user.' }
    expose :user_id, documentation: { type: 'Integer', desc: 'Id of user.' }
    expose :movie_id, documentation: { type: 'Integer', desc: 'Id of user.' }
    expose :reaction_type, documentation: { type: 'Integer', desc: 'Id of user.' }
  end
end
