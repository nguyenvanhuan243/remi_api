# Step 1: Install Gem
```
gem 'sentry-ruby', '4.5.1'
gem 'sentry-rails', '4.5.1'
```


# Step 2: Create sentry.rb in config/initializers with this content:
```
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
```

Note: Get code from this page: https://docs.sentry.io/platforms/ruby/guides/rails/

# Step 3: Check Sentry is working or not.
```
Sentry.capture_message("test message")
```


# How to using sentry
```
begin
  response = HTTParty.get("https://emailverifier.reoon.com/api/v1/verify?email=#{@email}&key=#{api_key}&mode=#{@mode}").parsed_response
  ::Sentry.capture_message("SENDING EMAIL BY EMAIL VERIFY: #{response['status']}") if response['status'] == 'error'
  ::Sentry.capture_message("MISSING API KEY EMAIL VERIFY") unless ENV['EMAIL_VERIFIER_TOKEN'].present?
  response['status'] == 'safe'
rescue => e
  ::Sentry.capture_exception(e)
end
```