module API
  module V1
    class Base < Grape::API
      helpers API::V1::Helpers
      prefix 'api'
      format :json
      version 'v1'
      use Rack::ConditionalGet
      use Rack::ETag
      mount API::V1::Users
      mount API::V1::Movies
      mount API::V1::Reactions
      mount API::V1::Payments

      # Admin
      mount API::V1::Admin::Users
      mount API::V1::Admin::Movies
      add_swagger_documentation(api_version: version, hide_format: true, hide_documentation_path: true)
    end
  end
end
