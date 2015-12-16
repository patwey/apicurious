class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(tweet_params[:text])

    redirect_to dashboard_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
