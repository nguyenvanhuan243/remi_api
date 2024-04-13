# frozen_string_literal: true

require 'httparty'

module Interactors
  module BlockchainWallet
    class Base
      def initialize
        @url = BlockchainWalleConst::BLOCKCHAIN_WALLET_API
        raise ErrorsHandler::ServiceUnAvailable unless @url
      end
    end
  end
end
