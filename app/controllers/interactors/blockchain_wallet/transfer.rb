# frozen_string_literal: true

require 'httparty'

module Interactors
  module BlockchainWallet
    class Transfer < Base
      attr_reader :amount
      attr_reader :to_address
      attr_reader :private_key_sender

      def initialize(amount = nil, to_address = nil, private_key_sender = nil)
        @amount = amount
        @to_address = to_address
        @private_key_sender = private_key_sender
      end

      # Interactors::BlockchainWallet::Transfer.new(amount, to_address, private_key_sender).call
      def call
        HTTParty.get(
          transfer_url
        )
      end

      private

      def transfer_url
        base_url = BlockchainWalletConst::BLOCKCHAIN_WALLET_API
        endpoint = '/blockchain/tranferUSDT'

        query_params = {
          amount: amount,
          toAddress: to_address,
          privateKeyOfSender: private_key_sender
        }

        "#{base_url}#{endpoint}?#{query_params.to_query}"
      end
    end
  end
end
