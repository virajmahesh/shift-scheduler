require 'set'

class Event < ActiveRecord::Base
  belongs_to :user
  has_many :shifts, dependent: :destroy
  has_many :event_issues, dependent: :destroy
  has_many :issues, through: :event_issues

  validates :event_name, presence: true
  validates :event_date, presence: true
  validates :location, presence: true
  validates :candidate, presence: true

  after_destroy :cleanup

  def cleanup
    UserActivity.destroy_all(event_id: self.id)
  end

  # Orders shifts by start time
  def ordered_shifts
    self.shifts.order('start_time')
  end

  def self.future_events
    self.where('event_date >= ?', Time.now.to_date).order(:event_date)
  end

  def formatted_event_date
    self.event_date.strftime '%B %-d, %Y'
  end
  
  def format time
    time.strftime '%l:%M %p'
  end

  def formatted_start_time
    self.format self.start_time
  end

  def formatted_end_time
    self.format self.end_time
  end

  def number_signed_up
    users_signed_up = Set.new
    self.shifts.each do |s|
        s.users.each do |u|
          users_signed_up.add(u.id)
        end
    end
    if users_signed_up.length > 0
      users_signed_up.length.to_s + ' Volunteer(s) have already signed up to help out with this event'
    else
      'Be the first to one to join!'
    end
  end

  # Return true if the issue is associated with the event
  def has_issue? issue
    EventIssue.exists? issue: issue, event: self
  end

  def populate_issues issues
    self.issues = Issue.where id: issues
    self.save
  end

  # Return the route that duplicates the event
  def duplicate_path
    "/event/#{self.id}/duplicate"
  end

  # Return the route that transfers ownership of the event
  def transfer_owner_path
    "/event/#{self.id}/transfer"
  end

  def duplicate creator
    new_event = self.dup

    new_event.user = creator
    new_event.event_name += '(Copy)'
    new_event.save

    # Duplicate each shift associated with the event.
    self.shifts.each do |shift|
      shift.duplicate new_event
    end

    new_event.issues << self.issues
    new_event.save

    new_event
  end

end
