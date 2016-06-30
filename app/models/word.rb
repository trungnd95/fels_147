class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers
  has_many :word_lessons
  accepts_nested_attributes_for :word_answers, allow_destroy: true
  validates :native_word, presence: true
  validates :meaning, presence: true
  validates :category_id, presence: true,
    numericality: true
  validates_associated :word_answers
end
