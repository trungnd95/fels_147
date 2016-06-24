class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :word_lessons
end
