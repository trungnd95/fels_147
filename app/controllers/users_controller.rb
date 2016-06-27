class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by id: params[:id]
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
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end