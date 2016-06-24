class WordAnswer < ActiveRecord::Base
  belongs_to :word

  validates :content, presence: true
  validates :word_id, presence: true,
    numericality: true
end
