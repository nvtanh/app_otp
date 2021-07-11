module Dashboard
  class BaseController < ApplicationController
    before_action :authenticate!

    private

    def authenticate!
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  end
end
