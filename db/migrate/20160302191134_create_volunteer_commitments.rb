class CreateVolunteerCommitments < ActiveRecord::Migration
  def change
    create_table :volunteer_commitments do |t|
      t.belongs_to :user
      t.belongs_to :shift

      t.timestamps null: false
    end
  end
end
