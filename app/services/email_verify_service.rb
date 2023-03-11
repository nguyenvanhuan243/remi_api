# require "sentry-ruby"
class EmailVerifyService
  def initialize(email, mode) # mode = quick || power
    @email = email
    @mode = mode
  end

  def valid
    return true if ['false', false, nil].include?(ENV['VALIDATE_EMAIL']) # bypass email verify service
    begin
      response = HTTParty.get("https://emailverifier.reoon.com/api/v1/verify?email=#{@email}&key=#{api_key}&mode=#{@mode}").parsed_response
      if response['status'] == 'error' # out of credit service
        ::Sentry.capture_message("SENDING EMAIL BY EMAIL VERIFY: #{response['status']}")
        return true
      end
      ::Sentry.capture_message("MISSING API KEY EMAIL VERIFY") unless ENV['EMAIL_VERIFIER_TOKEN'].present?
      response['status'] == 'safe'
    rescue => e
      ::Sentry.capture_exception(e)
      return false
    end
  end

  def message(english)
    valid ? valid_message(english) : invalid_message(english)
  end

  private

  def invalid_message(english)
    english ? 'This email does not exist, please check again!' : 'Email này không tồn tại, vui lòng kiểm tra lại!'
  end

  def valid_message(english)
    english ? 'This is valid email' : 'Email hợp lệ'
  end

  def api_key
    ENV['EMAIL_VERIFIER_TOKEN']
  end

end