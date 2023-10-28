# frozen_string_literal: true

require 'meilisearch'

module MeiliSearch
  class Api
    def initialize
      @client = MeiliSearch::Client.new(
        ENV['MEILI_URL'],
        ENV['MEILI_MASTER_KEY'],
        timeout: 15
      )
    end

    def add_documents(index, data)
      @client.index(index).add_documents(data)
    end

    def delete_documents(index)
      @client.index(index).delete_all_documents
    end

  end
end
