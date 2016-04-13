class ShiftSkill < ActiveRecord::Base
    belongs_to :shift
    belongs_to :skill
    validates :shift_id, presence: true, uniqueness: {scope: :skill_id}
    validates :skill_id, presence: true
end
