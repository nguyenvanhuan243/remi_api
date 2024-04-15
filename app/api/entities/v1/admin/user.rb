module API::Entities::V1::Admin
  class User < API::Entities::V1::Base
    expose :id, documentation: { type: 'Integer', desc: 'Id of user.' }
    expose :email, documentation: { type: 'String', desc: 'Email of user.' }
    expose :created_at, documentation: { type: 'Datetime', desc: 'Created at user.' }
  end
end
