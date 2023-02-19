class Admin::HomesController < ApplicationController
  def top
    @user = current_user
    @users = User.page(params[:page])
  end
end
