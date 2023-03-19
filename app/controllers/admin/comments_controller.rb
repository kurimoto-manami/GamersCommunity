class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to admin_contribution_path(params[:contribution_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:contribution_id, :substance, :favorite)
  end
end
