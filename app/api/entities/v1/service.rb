module API::Entities::V1
	class Service < API::Entities::V1::Base
		expose :id, documentation: { type: 'Integer', desc: 'Id of Service.' }
		expose :name, documentation: { type: 'String', desc: 'Name of Service.' }
		expose :description, documentation: { type: 'String', desc: 'Description of Service.' }
		expose :is_active, documentation: { type: 'Boolean', desc: 'active Service.' }
	end
end