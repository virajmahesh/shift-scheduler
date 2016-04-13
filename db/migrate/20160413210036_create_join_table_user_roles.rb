class CreateJoinTableUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.belongs_to :user
      t.belongs_to :role
    end
  end
end
