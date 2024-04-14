class API::Entities::V1::Payment < API::Entities::V1::Base
  expose :id, documentation: { type: 'Integer', desc: 'Order ID.' }
  expose :created_at, documentation: { type: 'Datetime', desc: 'Created Of User.' }
  expose :user_id, documentation: { type: 'Integer', desc: 'User ID' }
  expose :payment_type, documentation: { type: 'Integer', desc: 'Command role' }
  expose :value, documentation: { type: 'Float', desc: 'Value' }
  expose :transaction_hash, documentation: { type: 'String', desc: 'Value' }
  expose :status, documentation: { type: 'Integer', desc: 'status' }
  expose :chain, documentation: { type: 'String', desc: 'Chain' }

  def created_at
    object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def transaction_hash
    object.transaction_hash
  end

  def chain
    if object.payment_type == "deposit"
      return "BEP20"
    end
    "NAN"
  end
end
