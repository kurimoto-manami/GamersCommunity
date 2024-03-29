class Public::UsersController < ApplicationController
  before_action :set_user, :only => [:show, :favorites, :comments, :destroy]

  def index
    @users = User.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @contributions = @user.contributions
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
      flash[:notice] = "変更しました。"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :status)
  end

  def set_user
     @user = User.find_by(:id => params[:id])
  end
end
