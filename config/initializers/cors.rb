Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # In a prod app you'll restrict to specific origin(s).
    # for this will just allow from any.
    origins '*'

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end
