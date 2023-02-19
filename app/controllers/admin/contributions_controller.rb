class Admin::ContributionsController < ApplicationController
  def index
    @contributions = Contribution.page(params[:page])
  end
end
