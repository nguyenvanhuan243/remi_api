# frozen_string_literal: true

require 'httparty'

module Interactors
  module BlockchainWallet
    class CreateAddress < Base
      # Interactors::BlockchainWallet::CreateAddress.new.call
      def call
        create
      end

      private

      def create
        new_address_url = "#{@url}/blockchain/getNewWallet"
        HTTParty.get(new_address_url).parsed_response
      end
    end
  end
end
