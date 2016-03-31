class AddRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :description
    end
  end
end
