class Shift < ActiveRecord::Base
  belongs_to :event
  has_many :volunteer_commitments
  has_many :ShiftRoles
  has_many :roles, through: :ShiftRoles
  has_many :users, through: :volunteer_commitments
  has_one :user, through: :event

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :has_limit, inclusion: {in: [true, false]}

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
