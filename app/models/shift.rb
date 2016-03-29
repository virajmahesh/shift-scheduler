class Shift < ActiveRecord::Base
  belongs_to :event
  has_many :volunteer_commitments
  has_many :users, :through => :volunteer_commitments
  has_one :user, :through => :event

  def formatted_start_time
    self.start_time.strftime '%I:%M %p'
  end

  def formatted_end_time
    self.end_time.strftime '%I:%M %p'
  end
end
