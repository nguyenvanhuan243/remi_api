# frozen_string_literal: true

class Timeout_Api
  HTTPARTY_TIMEOUT_API = ENV.fetch('HTTPARTY_TIMEOUT_API', 100).to_i
end

class RedisConst
  URL = ENV["REDIS_URL"]
end
