module API
  module V1
    module Helpers
      extend Grape::API::Helpers

      def authenticate_user!
        error!('401 Unauthorized', 401) if bearer_token.nil?
        user_id = Authenticate.decode(bearer_token)['user_id']
        user ||= User.find_by(id: user_id)
        return user if user

        error!('401 Unauthorized', 401)
      end

      def authenticate_admin!
        error!('401 Unauthorized', 401) if bearer_token.nil?
        user_id = Authenticate.decode(bearer_token)['user_id']
        user ||= User.admin.find_by(id: user_id)
        return user if user

        error!('401 Unauthorized', 401)
      end

      params :authorization_token do
        optional :Authorization, type: String, desc: 'Access Token', documentation: { param_type: :header }
      end

      def bearer_token
        pattern = /^Bearer /
        header  = request.headers['Authorization']
        header.gsub(pattern, '') if header && header.match(pattern)
      end
    end
  end
end
