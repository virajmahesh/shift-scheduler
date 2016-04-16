class Skill < ActiveRecord::Base
    validates :description, presence: true
end
