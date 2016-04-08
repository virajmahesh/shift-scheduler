class UserActivity < ActiveRecord::Base
    belongs_to :user
    belongs_to :activity_type
    belongs_to :shift
    
    @@join_shift_id = 1
    @@leave_shift_id = 2
    @@shift_full_id = 3
    @@event_time_id = 4
    @@shift_time_id = 5
    
    def self.join_shift_id; @@join_shift_id; end
    
    def self.leave_shift_id; @@leave_shift_id; end
        
    def self.shift_full_id; @@shift_full_id; end
        
    def self.event_time_id; @@event_time_id; end
    
    def self.shift_time_id; @@shift_time_id; end
        
    def representation
        my_activity = ActivityType.find_by id: activity_id
        if activity_id == @@event_time_id || activity_id == @@shift_time_id
            my_activity.activity
        else
            my_activity.activity + shift.role
        end
    end
        
        
    
end
