class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(auth_hash)
      session[:user_id] = user.id
    end
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
