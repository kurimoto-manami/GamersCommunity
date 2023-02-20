class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
end
