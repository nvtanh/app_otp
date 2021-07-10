class OneTimePassword < ApplicationRecord
  DEFAULT_OTP_LENGTH = 4
  DEFAULT_OTP_DEBUG_MODE = '1234'.freeze
  DEFAULT_EXPIRED_TIME = 15.minutes

  attr_accessor :otp

  before_create :set_otp
  before_create :update_expiring_time
  after_create :send_otp

  belongs_to :user

  delegate :email, to: :user, prefix: true

  private

  def set_otp
    self.otp = generate_otp
    self.encrypted_otp = BCrypt::Password.create(self.otp)
  end

  def update_expiring_time
    self.expired_at = Time.current + DEFAULT_EXPIRED_TIME
  end

  def generate_otp(n = DEFAULT_OTP_LENGTH)
    otp = if ENV['APP_MODE'].present? && ENV['APP_MODE'] == 'debug'
      DEFAULT_OTP_DEBUG_MODE
    else
      maximum_number = (10 ** n) - 1
      rand(maximum_number).to_s.center(n, rand(9).to_s).to_s
    end
  end

  def send_otp
    UserMailer.send_otp(self.user_email, self.otp).deliver_later
  end
end
