class Public::FavoritesController < ApplicationController

  def create
    contribution = Contribution.find(params[:contribution_id])
    favorit = current_user.favorites.new(contribution_id: contribution.id)
    favorit.save
    redirect_to contribution_path(contribution)
  end

  def destroy
    contribution = Contribution.find(params[:contribution_id])
    favorit = current_user.favorites.find_by(contribution_id: contribution.id)
    favorit.destroy
    redirect_to contribution_path(contribution)
  end
end
