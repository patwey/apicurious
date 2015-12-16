class FavoritesController < ApplicationController
  def create
    current_user.favorite(params[:id])

    redirect_to dashboard_path
  end
end
