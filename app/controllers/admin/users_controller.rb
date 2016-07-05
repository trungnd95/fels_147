class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :check_admin

  def index
    @users = User.includes(:lessons, :categories).where("is_admin = ?", false)
      .paginate page: params[:page], per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.json{render json: @users}
    end
  end

  def destroy
    @user =  User.find_by id: params[:id]
    @user.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t "page.admin.words.delete.success"
        redirect_to admin_categories_path
      end
      format.json{head :nocontent}
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :avatar, :activated,
      :confirmation_code
  end
end
