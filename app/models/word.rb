class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :word_lessons, dependent: :destroy
  has_many :lessons, through: :word_lessons

  accepts_nested_attributes_for :word_answers, allow_destroy: true

  validates :native_word, presence: true
  validates :meaning, presence: true
  validates :category_id, presence: true,
    numericality: true
  validates_associated :word_answers

  scope :order_word, ->{order("created_at DESC")}
  scope :current_user_words, ->(category_id){where category_id: category_id}
  scope :learned, ->(ids){where id: ids}
  scope :true_words, ->(ids){joins(:word_lessons).where(words: {id: ids})
    .where(word_lessons: {result: true})}
  scope :false_words, ->(ids){joins(:word_lessons).where(words: {id: ids})
    .where(word_lessons: {result: false})}
  scope :not_learn, ->(ids){where.not id: ids}
  scope :_all, ->ids{}
end
