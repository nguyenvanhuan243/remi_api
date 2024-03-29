Sentry.init do |config|
  config.dsn = 'https://b8e8b651129eff2369a8b443ea2e4af4@o362235.ingest.us.sentry.io/4506992930258944'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
