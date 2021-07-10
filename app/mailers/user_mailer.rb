class UserMailer < ApplicationMailer
  def send_otp(email, otp)
    @otp = otp

    mail(to: email, subject: '[OTP APP] OTP Bound to Your Account')
  end
end
