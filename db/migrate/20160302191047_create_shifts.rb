class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.belongs_to :event
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :has_limit
      t.integer :limit

      t.timestamps null: false
    end
  end
end
