class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :text, default: 'User'
  end
end
