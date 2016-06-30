class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories=Category.order("created_at DESC").paginate(page: params[:page],
      per_page: Settings.per_page)
  end
end
