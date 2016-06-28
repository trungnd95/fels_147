class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :word_lessons
  has_many :lessons, through: :word_lessons

  validates :content, presence: true
end
