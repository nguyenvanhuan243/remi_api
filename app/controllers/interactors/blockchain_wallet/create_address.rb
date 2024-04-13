# frozen_string_literal: true

require 'httparty'

module Interactors
  module BlockchainWallet
    class CreateAddress < Base
      # Interactors::BlockchainWallet::CreateAddress.new.call
      def call
        HTTParty.get(create_address_url).parsed_response
      end

      private

      def create_address_url
        "#{@url}/blockchain/getNewWallet"
      end
    end
  end
end
