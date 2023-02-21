class Admin::ContributionsController < ApplicationController
  
  def index
    @contributions = Contribution.page(params[:page])
  end
  
  def show
    @contribution = Contribution.find(params[:id])
  end
  
  def update
    @contribution = Contribution.find(params[:id])
  end
  
  def destroy
    @contribution = Contribution.find(params[:id])
  end
end
