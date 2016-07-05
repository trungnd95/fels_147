class ChangeActityTypeInActivities < ActiveRecord::Migration
  def change
    change_column :activities, :activity_type, :int
  end
end
