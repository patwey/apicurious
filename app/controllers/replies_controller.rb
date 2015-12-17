class RepliesController < ApplicationController
  def new
    @reply_to_id = params[:id]
    @reply_to_screenname = params[:screen_name]
  end

  def create
    current_user.reply(params[:reply][:text], params[:screen_name], params[:id])

    redirect_to dashboard_path
  end
end
