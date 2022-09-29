module API::Entities::V1
    class Admin < API::Entities::V1::Base
        expose :id, documentation: { type: 'Integer', desc: 'Id of admin.' }
	end
end