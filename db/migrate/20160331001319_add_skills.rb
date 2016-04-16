class AddSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :description
    end
  end
end
