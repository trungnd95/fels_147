class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :user_finder, only: [:show, :edit, :correct_user]

  def index
    @users = User.all
  end

  def show
    if @user.nil?
      redirect_to root_url
    end
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
      params.require(:user).permit :name, :email, :avatar, :password, :password_confirmation
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = t "message.plsLogin"
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to root_url unless current_user? @user
    end

    def user_finder
      @user = User.find_by id: params[:id]
    end
end
