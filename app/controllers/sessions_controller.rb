class SessionsController < ApplicationController
  before_action :verify_email, only: :create

  def new
  end

  def create
    if verify_otp_step?
      is_verified, errors = VerifyOtpService.new(@user, session_params[:otp]).excute!
      if is_verified
        log_in @user
        flash[:notice] = "Welcome to OTP"
        redirect_to dashboard_root_path
      else
        flash[:danger] = errors
        render :new
      end

    else
      OneTimePassword.create(user: @user)
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :otp)
  end

  def verify_otp_step?
    session_params[:otp].present?
  end

  def verify_email
    @user = User.find_by(email: session_params[:email].downcase)
    return if @user.present?
    flash[:danger] = "User not found!"
    render :new
  end
end
