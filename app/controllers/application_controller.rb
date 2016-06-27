class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def is_admin
    if logged_in?
      redirect_to root_path unless current_user.is_admin?
    else
      redirect_to root_path
    end
  end
end
