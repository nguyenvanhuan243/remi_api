module API::Entities::V1
    class Footer < API::Entities::V1::Base
        expose :id, documentation: { type: 'Integer', desc: 'Id of Footer.' }
        expose :key, documentation: { type: 'String', desc: 'Id of Footer.' }
        expose :value, documentation: { type: 'String', desc: 'Id of Footer.' }
        expose :active, documentation: { type: 'Boolean', desc: 'Id of Footer.' }
	end
end