class EventIssue < ActiveRecord::Base
    belongs_to :event
    belongs_to :issue
    validates :issue_id, presence: true
    validates :event_id, presence: true, uniqueness: {scope: :issue_id}
end
