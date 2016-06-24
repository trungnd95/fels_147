class CreateWordLessons < ActiveRecord::Migration
  def change
    create_table :word_lessons do |t|
      t.integer :answer_id
      t.references :lesson, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
