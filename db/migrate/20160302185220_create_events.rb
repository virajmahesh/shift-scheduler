class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :description
      t.string :location
      t.datetime :event_date
      t.string :event_name
      t.string :candidate
      t.timestamps null: false
    end

  end
end
