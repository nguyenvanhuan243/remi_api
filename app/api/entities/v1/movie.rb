module API::Entities::V1
	class Movie < API::Entities::V1::Base
		expose :id, documentation: { type: 'Integer', desc: 'Movie ID' }
		expose :title, documentation: { type: 'String', desc: 'Movie Title.' }
    expose :description, documentation: { type: 'String', desc: 'Movie Description' }
    expose :shared_by, documentation: { type: 'String', desc: 'Movie Description' }
		expose :embed_url, documentation: { type: 'String', desc: 'Movie Description' }
		expose :like, documentation: { type: 'String', desc: 'Movie Description' }
		expose :like_list, documentation: { type: 'String', desc: 'Movie Description' }
		expose :total_likes, documentation: { type: 'String', desc: 'Movie Description' }
		expose :total_dislikes, documentation: { type: 'String', desc: 'Movie Description' }
	end
end