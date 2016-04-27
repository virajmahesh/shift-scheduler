class AddIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :description
    end
  end
end
