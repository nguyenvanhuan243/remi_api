GrapeSwaggerRails.options.url = '/api/v1/swagger_doc'
is_https = Rails.env.production? ? URI::HTTPS : URI::HTTP
GrapeSwaggerRails.options.app_url = is_https.build(Rails.application.routes.default_url_options).to_s
GrapeSwaggerRails.options.app_name = 'Remitano'
