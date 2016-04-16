class FixActivitiy < ActiveRecord::Migration
  def change
    change_table :user_activities do |t|
     t.rename :activity_id, :activity_type_id
     t.integer :event_id
    end
  end
end
