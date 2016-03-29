class Shift < ActiveRecord::Base
  belongs_to :event
  has_many :volunteer_commitments
  has_many :users, :through => :volunteer_commitments
  has_one :user, :through => :event

  def format time
    time.strftime '%I:%M %p'
  end

  def formatted_start_time
    self.format self.start_time
  end

  def formatted_end_time
    self.format self.end_time
  end
end
