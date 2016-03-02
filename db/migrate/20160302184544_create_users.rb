class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :skills
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
