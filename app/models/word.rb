class Word < ActiveRecord::Base
  belongs_to :cateogry
  has_many :word_answers
  has_many :word_lessons

  validates :native_word, presence: true
  validates :meaning, presence: true
  validates :category_id, presence: true,
    numericality: true
end
