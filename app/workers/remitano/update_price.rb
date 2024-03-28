# frozen_string_literal: true

class Remitano::UpdatePrice
  include Sidekiq::Worker

  def initialize
    puts "Remitano::UpdatePrice"
  end

  def perform
    puts "Remitano::UpdatePrice"
  rescue StandardError => e
    Sentry.capture_exception(e)
  end
end
