source 'https://rubygems.org'
ruby '2.6.8'

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

gem 'coffee-rails', '~> 4.2'
gem 'grape'
gem 'grape-entity'
gem 'grape-rails-cache'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'open_uri_redirections'
gem 'puma', '~> 3.0'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.0.1'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'select2-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'yard'
gem 'coffee-rails', '~> 4.2'
gem 'enumerize'
gem 'figaro'
gem 'httparty'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jwt'
gem 'newrelic_rpm'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'sentry-rails', '4.5.1'
gem 'sentry-ruby', '4.5.1'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'
gem 'video_info'
gem 'pundit'

# sidekiq
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq-gelf'
gem 'rack-cors'

gem 'redis-rails', '~> 5'
gem "redis", "~> 3.3"

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'rails_best_practices'
  gem 'annotate'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'site_prism'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'dotenv-rails'
end
