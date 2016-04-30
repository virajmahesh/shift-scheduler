class DropActivitiesTable < ActiveRecord::Migration
  def change
    drop_table :activity_types
    remove_column :user_activities, :activity_type_id
  end
end
