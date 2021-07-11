class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exception)
    flash[:danger] = exception.message
    redirect_to root_path
  end
end
