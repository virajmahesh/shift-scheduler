class UserSkill < ActiveRecord::Base
    belongs_to :user
    belongs_to :skill
    validates :user_id, presence: true, uniqueness: {scope: :skill_id}
    validates :skill_id, presence: true
end
