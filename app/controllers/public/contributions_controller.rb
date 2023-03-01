class Public::ContributionsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @contribution = Contribution.new
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    if @contribution.save
      flash[:notice]="You have created book successfully."
      redirect_to contribution_path(@contribution.id)
    else
      @user = @contribution.user
      @contributions = Contribution.all
      render :index
    end
  end

  def index
    @contributions = Contribution.all
    @user = current_user
    @contribution = Contribution.new
  end

  def show
    # @show = Book.new
    @contribution = Contribution.find(params[:id])
    @user = @contribution.user
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    @contributions = Contribution.all
    @contribution = Contribution.find(params[:id])
    if @contribution.update(contribution_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to contribution_path(@contribution.id)
    else
      @user = @contribution.user
      render :edit
    end
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to contributions_path
  end

  private

  def contribution_params
    params.require(:contribution).permit(:title, :body, :user_id, :genre_id)
  end
  
  def corrent_user
    @contribution = Contribution.find(params[:id])
    @user = @contribution.user
    if(current_user.id != @user.id)
      redirect_to contributions_path
    end
  end
end
