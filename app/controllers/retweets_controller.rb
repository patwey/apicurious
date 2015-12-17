class RetweetsController < ApplicationController
  def create
    current_user.retweet(params[:id])

    redirect_to dashboard_path
  end
end
