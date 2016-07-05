class Activity < ActiveRecord::Base
  belongs_to :user
  enum activity_type: {learned: 1, learning: 2, follow: 3, unfollow: 4}
  scope :order_by_time, ->{order("created_at DESC")}

  def load_lesson
    Lesson.find_by id: self.target_id
  end

  def load_user
    User.find_by id: self.target_id
  end
end
