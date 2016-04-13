class UserActivity < ActiveRecord::Base
    belongs_to :user
    belongs_to :activity_type
    belongs_to :shift
    
    @@join_shift_id = 1
    @@leave_shift_id = 2
    @@shift_full_id = 3
    
    def self.join_shift_id; @@join_shift_id; end
    
    def self.leave_shift_id; @@leave_shift_id; end
        
    def self.shift_full_id; @@shift_full_id; end
        
    def representation
        my_activity = ActivityType.find_by id: activity_id
        my_activity.activity + shift.role
    end
end
