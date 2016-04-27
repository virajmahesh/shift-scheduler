class CreateJoinTableEventIssues< ActiveRecord::Migration
  def change
    create_table :event_issues do |t|
      t.belongs_to :event
      t.belongs_to :issue
    end
  end
end
