class Category < ActiveRecord::Base
  has_many :lessons
  has_many :users, through: :lessons
  has_many :words

  validates :name, presence: true
  validates :description, presence: true
end
