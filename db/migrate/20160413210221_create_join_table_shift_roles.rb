class CreateJoinTableShiftRoles < ActiveRecord::Migration
  def change
    create_table :shift_roles do |t|
      t.belongs_to :shift
      t.belongs_to :role
    end
  end
end
