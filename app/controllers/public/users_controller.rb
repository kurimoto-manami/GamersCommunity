class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path
    end
    @user = User.find(params[:id])
  end
  
  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path
    end
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :is_deleted)
  end
end
