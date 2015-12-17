class RepliesController < ApplicationController
  def new
    @reply_to_id = params[:id]
    @reply_to_screenname = params[:screen_name]
  end

  def create
    reply = reply_text(params[:screen_name], params[:reply][:text])
    current_user.reply(reply, params[:id])

    redirect_to dashboard_path
  end

  private

  def reply_text(screen_name, text)
    "@#{screen_name} #{text}"
  end
end
