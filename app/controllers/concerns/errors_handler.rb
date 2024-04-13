# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  class BadRequest < StandardError; end

  class ServiceUnAvailable < StandardError; end

  included do
    rescue_from ServiceUnAvailable, with: :handle_service_unavailable
  end

  private

  def handle_service_unavailable(_exception)
    render json: json_with_error(
      message: I18n.t('errors.service_unavailable')
    ), status: :unprocessable_entity
  end
end
