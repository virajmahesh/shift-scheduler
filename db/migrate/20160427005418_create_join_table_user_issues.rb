class CreateJoinTableUserIssues < ActiveRecord::Migration
  def change
    create_table :user_issues do |t|
      t.belongs_to :user
      t.belongs_to :issue
    end
  end
end
