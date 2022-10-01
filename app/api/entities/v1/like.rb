module API::Entities::V1
	class Like < API::Entities::V1::Base
		expose :id, documentation: { type: 'Integer', desc: 'Movie ID' }
		expose :status, documentation: { type: 'Integer', desc: 'Movie ID' }
		expose :movie_id, documentation: { type: 'Integer', desc: 'Movie ID' }
		expose :user_id, documentation: { type: 'Integer', desc: 'Movie ID' }
	end
end