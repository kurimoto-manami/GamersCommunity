class Public::ContributionsController < ApplicationController
  before_action :corrent_user, only: [:edit, :update, :destroy]

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @contributions = Contribution.looks(params[:search], params[:word])
    end
  end

  def new
    @contribution = Contribution.new
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
    if params[:tag_ids]
      @contributions = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_contributions = Tag.find_by(name: key).contributions
          @contributions = @contributions.empty? ? tag_contributions : @contributions & tag_contributions
        end
      end
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
    @user = @contribution.user
    @comment = Comment.new
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      # redirect_to user_path
    end
    @contributions = Contribution.all
    @contribution = Contribution.find(params[:id])
    if @contribution.update(contribution_params)
      flash[:notice] = "投稿内容を更新しました。"
      redirect_to contribution_path(@contribution.id)
    else
      @user = @contribution.user
      render :edit
    end
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to user_path(@user.id)
  end

  private

  def contribution_params
    params.require(:contribution).permit(:title, :body, :user_id, :genre_id, tag_ids: [])
  end

  def corrent_user
    @contribution = Contribution.find(params[:id])
    @user = @contribution.user
    if(current_user.id != @user.id)
      redirect_to contributions_path
    end
  end
end
