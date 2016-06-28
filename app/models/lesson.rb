class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :word_lessons, dependent: :destroy
  has_many :words, through: :word_lessons
  has_many :word_answers, through: :word_lessons
  has_many :activities, dependent: :destroy

  accepts_nested_attributes_for :word_lessons,
    reject_if: lambda {|a| a[:word_id].blank?}, allow_destroy: true

  validate :word_min, on: :create

  before_update :change_is_completed

  def create_word
    self.words = if category.words.size >= Settings.word_size
      category.words.order("RANDOM()").limit Settings.number_words_per_lesson
    else
      category.words.order("RANDOM()")
    end
  end

  private
  def change_is_completed
    self.update_attributes is_completed: true unless self.is_completed?
  end

  def word_min
    errors.add :create,
      I18n.t("category.lesson.create_fail") if self.words.size < Settings.number_words_min
  end
end
