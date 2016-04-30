class AddOwnerIdToUserActivities < ActiveRecord::Migration
  def change
    add_column :user_activities, :owner_id, :integer
    add_column :user_activities, :type, :string
  end
end
