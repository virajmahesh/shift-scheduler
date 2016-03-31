class AddShiftIdToUserActivity < ActiveRecord::Migration
  def change
    add_column :user_activities, :shift_id, :integer
  end
end
