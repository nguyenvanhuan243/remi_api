module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user   = set_user
    end

    protected

    def set_user
      token = request.params[:token]
      raise I18n.t("errors.missing_token") if token.blank?

      verify_user(token)
    rescue Exception => e
      Rails.logger.debug "An exception was thrown: #{e.message}"
      reject_unauthorized_connection
    end

    private

    def verify_user(token)
      user = Authenticate.decode(token.gsub(/^Bearer /, ''))
      OpenStruct.new(user)
    end
  end
end
