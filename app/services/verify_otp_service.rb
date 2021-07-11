class VerifyOtpService
  def initialize user, input_otp
    @user = user
    @input_otp = input_otp
  end

  def call
    err_message = ""
    is_verified = correct_otp?
    if is_verified
      raise 'OTP exprired!' if expired?
      otp.update(verified_at: Time.current)
    else
      raise 'OTP invalid!'
    end
    [is_verified, err_message]
  rescue StandardError => e
    is_verified = false
    err_message = e.message
    [is_verified, err_message]
  end

  private

  def otp
    @otp ||= @user.one_time_passwords.last
    if @otp.blank?
      raise 'OTP invalid'
    end
    @otp
  end

  def expired?
    otp.expired_at.nil? || otp.expired_at < Time.current
  end

  def correct_otp?
    BCrypt::Password.new(otp.encrypted_otp) == @input_otp
  end
end