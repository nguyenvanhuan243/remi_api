require 'jwt'
class Authenticate
  ALGORITHM = 'HS256'
  def self.issue(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
  end

  def self.auth_secret
    ENV['AUTH_SECRET']
  end

  def self.jwt_valid?(token)
    return false if !token || !valid_token(token)

    true
  end

  def self.valid_token(token)
    return false unless token

    begin
      decoded_token = decode(token)
      return true
    rescue JWT::DecodeError
      Rails.logger.warn 'Error decoding the JWT'
    end
    false
  end
end
