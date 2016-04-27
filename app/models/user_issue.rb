class UserIssue < ActiveRecord::Base
    belongs_to :user
    belongs_to :issue
    validates :user_id, presence: true, uniqueness: {scope: :issue_id}
    validates :issue_id, presence: true
end
