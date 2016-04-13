class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.datetime :event_date
      t.string :event_name
      t.string :candidate
      t.timestamps null: false
    end

  end
end
