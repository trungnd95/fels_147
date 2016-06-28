class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :check_admin
  before_action :load_category, except: [:index, :create]
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

  def edit
  end

  def update
    respond_to do |format|
      if @category.update category_params
        format.html do
          redirect_to admin_categories_path,
           success: t("page.admin.categories.edit.success")
        end
        format.json do
          render json: @category, status: :ok
        end
      else
        format.html do
          redirect_to :back,
          danger: t("page.admin.categories.edit.danger")
        end
        format.json do
          render json: @category.errors,
            status: :unprocessable_entity
        end
      end
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
