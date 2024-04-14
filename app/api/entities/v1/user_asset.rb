class API::Entities::V1::UserAsset < API::Entities::V1::Base
  expose :id, documentation: { type: 'Integer', desc: 'Id of user.' }
  expose :balance, documentation: { type: 'Integer', desc: 'From platform.' }
  expose :locked_balance, documentation: { type: 'String', desc: 'Email of user.' }
  expose :currency, documentation: { type: 'String', desc: 'Email of user.' }
  expose :created_at, documentation: { type: 'Datetime', desc: 'Created at user.' }
  expose :updated_at, documentation: { type: 'Datetime', desc: 'Created at user.' }
end
