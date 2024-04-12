source 'https://rubygems.org'
ruby '2.6.8'

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

gem 'grape'
gem 'grape-entity'
gem 'grape-rails-cache'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'httparty'
gem 'jwt'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'video_info'

# sidekiq
gem 'rack-cors'
gem 'sidekiq'
gem 'sidekiq-gelf'

gem 'redis', '~> 3.0'
gem 'redis-rails'

group :development do
  gem 'annotate'
  gem 'rubocop'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end
