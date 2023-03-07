class Public::CommentsController < ApplicationController

  def create
    contribution = Contribution.find(params[:contribution_id])
    comment = current_user.comments.new(comment_params)
    comment.contribution_id = contribution.id
    comment.save
    redirect_to contribution_path(contribution)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to contribution_path(params[:contribution_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
