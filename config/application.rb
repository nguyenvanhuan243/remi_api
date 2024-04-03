require_relative 'boot'
require 'openssl'
require 'rails/all'
require "action_cable/engine"
Bundler.require(*Rails.groups)

module Remitano
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options delete put]
      end
    end
    config.autoload_paths += Dir["#{Rails.root}/app"]
    config.eager_load_paths << Rails.root.join('lib')
    if Rails.env != "production"
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    end
    config.action_cable.mount_path = ENV.fetch('WEBSOCKET_MOUNT_PATH', '/cable')
    config.action_cable.disable_request_forgery_protection = true
  end
end
