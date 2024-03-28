Sidekiq.configure_server do |config|
  config.redis = { url: RedisConst::URL }
end
Sidekiq.configure_client do |config|
  config.redis = { url: RedisConst::URL }
end

schedule_file = 'config/schedule.yml'
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
