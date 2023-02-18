Sentry.init do |config|
  config.dsn = 'https://493db188648740d7b8a7037cf5faf9d2@o4504698737983488.ingest.sentry.io/4504698738966528'

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end