class UserActivity < ActiveRecord::Base
    belongs_to :user
    belongs_to :activity_type
    belongs_to :shift
    belongs_to :event
    
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
        if shift != nil
            activity_type.activity + shift.role
        else
            activity_type.activity + event.event_name
        end
    end
        
    
end