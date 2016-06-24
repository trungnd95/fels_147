class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.boolean :activated
      t.string :confirmation_code
      t.boolean :is_admin, default: false

      t.timestamps null: false
    end
    add_index :users, :email
  end
end
