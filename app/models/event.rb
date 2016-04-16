require 'set'

class Event < ActiveRecord::Base
  belongs_to :user
  has_many :shifts

  validates :event_name, presence: true
  validates :event_date, presence: true
  validates :location, presence: true
  validates :candidate, presence: true

  # Orders shifts by start time
  def ordered_shifts
    self.shifts.order('start_time')
  end

  def self.future_events
    self.where('event_date > ?', Time.now.to_date)
  end

  def formatted_event_date
    self.event_date.strftime '%B %-d %Y'
  end
  
  def format time
    time.strftime '%I:%M %p'
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

end
