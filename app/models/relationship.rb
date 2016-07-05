class Relationship < ActiveRecord::Base
  include CreateActivity

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  after_create :create_activity_follow
  before_destroy :create_activity_unfollow

  private
  def create_activity_follow
    create_activity self.followed_id, Settings.activity_type.follow, self.follower_id
  end

  def create_activity_unfollow
    create_activity self.followed_id, Settings.activity_type.unfollow, self.follower_id
  end
end
