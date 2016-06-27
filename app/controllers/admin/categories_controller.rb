class Admin::CategoriesController < ApplicationController
  layout "admin"
  def index
    @categories = Category.includes(:words).paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.json{render json: @categories}
    end
  end
end
