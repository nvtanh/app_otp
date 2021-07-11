module AuthenticationHelper
  def anonymous_session
    {}
  end

  def login_as(user)
    session[:user_id] = user.id
  end
end
