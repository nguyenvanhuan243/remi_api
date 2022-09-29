module API
  module V1
    class Base < Grape::API
      helpers API::V1::Helpers
      # helpers Garner::Mixins::Rack
      # include API::V3::ExceptionsHandler
      # include Garner::Mixins::Rack
      prefix 'api'
      format :json
      version 'v1'
      use Rack::ConditionalGet
      use Rack::ETag

      # before do
      #   set_access_token
      #   set_locale
      # end

      mount API::V1::Users
      mount API::V1::Movies

      add_swagger_documentation(api_version: self.version, hide_format: true, hide_documentation_path: true)
    end
  end
end
