class Event < ActiveRecord::Base
  belongs_to :user
  has_many :shifts

  validates :event_name, :presence => true
  validates :event_date, :presence => true

  def ordered_shifts
    self.shifts.order("start_time")
  end

  def self.future_events
    self.where('event_date > ?', Time.now.to_date)
  end

  def formatted_event_date
    self.event_date.strftime '%B %-d %Y'
  end
end
