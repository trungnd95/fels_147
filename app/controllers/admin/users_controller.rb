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

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :avatar, :activated,
      :confirmation_code
  end
end
