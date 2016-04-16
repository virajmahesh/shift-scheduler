class CreateJoinTableShiftSkills < ActiveRecord::Migration
  def change
    create_table :shift_skills do |t|
      t.belongs_to :shift
      t.belongs_to :skill
    end
  end
end
