# frozen_string_literal: true

class Timeout_Api
  HTTPARTY_TIMEOUT_API = ENV.fetch('HTTPARTY_TIMEOUT_API', 100).to_i
end

class RedisConst
  URL = ENV.fetch('REDIS_URL',
                  'rediss://red-co2g19821fec73asnucg:3dS5twfvvT3rB96XphF1vddRocKcFvzO@oregon-redis.render.com:6379')
end
