class AddReadColumnToNotifications < ActiveRecord::Migration
  def change
    add_column :user_activities, :read, :boolean
    change_column_default :user_activities, :read, false
  end
end
