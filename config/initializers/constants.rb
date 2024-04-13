# frozen_string_literal: true

class RedisConst
  URL = ENV['REDIS_URL']
end

class BlockchainWalletConst
  BLOCKCHAIN_WALLET_API = ENV.fetch('BLOCKCHAIN_WALLET_API', 'https://deposit-usdt-testnet.onrender.com')
end
