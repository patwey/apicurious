class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(params[:text])

    redirect_to dashboard_path
  end
end
