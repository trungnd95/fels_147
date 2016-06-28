class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :check_admin
  def index
    @categories = Category.includes(:words).paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.json{render json: @categories}
    end
  end

  def new
  end

  def create
    @category = Category.new category_params
    respond_to do |format|
      if @category.save
        format.html{redirect_to @category,
          success: t("page.admin.categories.create.success")}
        format.json{render json: @category, status: :created}
      else
        format.html{render :new}
        format.json{render json: @category.errors, status: :unprocessable_entity}
      end
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
