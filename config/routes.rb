require 'sidekiq/web'
require 'sidekiq/cron/web'
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_USERNAME'], ENV['SIDEKIQ_PASSWORD']]
end
Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount API::V1::Base => '/'
  mount Sidekiq::Web, at: '/sidekiq'
end
