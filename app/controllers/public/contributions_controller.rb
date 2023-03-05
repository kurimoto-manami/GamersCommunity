class Public::ContributionsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def search
    @contributions = Contribution.search(params[:keyword])
  end
  
  def new
    @contribution = Contribution.new
    @genres = Genre.all
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    if @contribution.save
      flash[:notice]="新規投稿に成功しました。"
      redirect_to contribution_path(@contribution.id)
    else
      @user = @contribution.user
      @contributions = Contribution.all
      render :index
    end
  end

  def index
    @contributions = Contribution.page(params[:page]).per(10)
    @user = current_user
  end

  def show
    @contribution = Contribution.find(params[:id])
    @user = @contribution.user
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path
    end
    @contributions = Contribution.all
    @contribution = Contribution.find(params[:id])
    if @contribution.update(contribution_params)
      flash[:notice] = "情報を更新しました。"
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
