class ShiftRole < ActiveRecord::Base
    belongs_to :shift
    belongs_to :role
    validates :shift_id, presence: true
    validates :role_id, presence: true
end
