class Admin::CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @user = @comment.user
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_contribution_path
  end

  private

  def comment_params
    params.require(:comment).permit(:contribution_id, :substance, :favorite)
  end
end
