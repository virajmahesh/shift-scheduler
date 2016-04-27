class EventIssue < ActiveRecord::Base
    belongs_to :event
    belongs_to :issue
    validates :event_id, presence: true, uniqueness: {scope: :issue_id}
    validates :issue_id, presence: true
end
