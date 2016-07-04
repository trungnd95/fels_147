class AddColumnToWordLesson < ActiveRecord::Migration
  def change
    add_column :word_lessons, :result, :boolean
  end
end
