class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :word_lessons
  has_many :lessons, through: :word_lessons

  after_initialize :init

  def init
    self.is_correct  ||= false
  end

  validates :content, presence: true
end
