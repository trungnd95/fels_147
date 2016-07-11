class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :load_user, only: [:show, :edit, :update, :correct_user]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.order(created_at: :desc)
      .paginate page: params[:page],per_page: Settings.per_page
  end

  def show
    @activities = @user.activities.order_by_time.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "message.success.create_user"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "userLink.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
