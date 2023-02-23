class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to admin_user_path(@user.id)
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
    flash[:notice] = "利用停止しました。"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :is_deleted)
  end

  def admin_check
    if admin_signed_in? && current_admin.role == "admin"
        riderect_to new_admin_product_path
    else
        render action: :edit
        flash[:alert] = "管理者画面です"
    end
  end
end
