class WordLesson < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer

  scope :is_corrects, -> do
    joins(:word_answer).where word_answers:{is_correct: true}
  end
end
