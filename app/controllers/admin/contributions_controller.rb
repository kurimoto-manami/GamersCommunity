class Admin::ContributionsController < ApplicationController

  def index
    @contributions = Contribution.page(params[:page])
  end

  def show
    @contribution = Contribution.find(params[:id])
    # @comments = @contribution.comment
  end

  def update
    @contribution = Contribution.find(params[:id])
    if @contribution.update(contribution_params)
      frash[:notice] = "更新しました。"
      redirect_to contribution_path(@contribution.id)
    else
      @user = @contribution.user
      render :show
    end
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to admin_contributions_path
  end

  private

  def contribution_params
    params.require(:contribution).permit(:user_id, :genre_id, :title, :body)
  end
end
