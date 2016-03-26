require 'set'

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

  def number_signed_up
    users_signed_up = Set.new
    self.shifts.each do |s|
        users_signed_up.add(s.users.ids)
    end
    if users_signed_up.length > 0
      users_signed_up.length.to_s + " user(s) signed up."
    else
      "Be the first to sign up for the event."
    end
  end

end
