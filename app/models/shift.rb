class Shift < ActiveRecord::Base
  belongs_to :event
  has_many :volunteer_commitments
  has_many :shift_skills
  has_many :skills, through: :shift_skills
  has_many :users, through: :volunteer_commitments
  has_one :user, through: :event

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :role, presence: true
  validates :has_limit, inclusion: {in: [true, false]}

  after_destroy :cleanup

  def cleanup
    UserActivity.destroy_all(shift_id: self.id)
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

  def populate_skills skills
    self.skills = Skill.where id: skills
    self.save
  end

  def duplicate event
    new_shift = self.dup

    new_shift.event = event
    new_shift.save

    new_shift.skills << self.skills
    new_shift.save

    new_shift
  end

  def has_skill? skill
    ShiftSkill.exists? shift: self, skill: skill
  end
end
