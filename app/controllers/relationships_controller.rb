class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:id]
    type = params[:relationship_type]
    @title = t "relationship.#{type}"
    @users = @user.send(type).paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
