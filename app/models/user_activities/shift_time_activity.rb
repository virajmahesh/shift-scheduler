class ShiftTimeActivity < UserActivity
    validate :commitment_exists
    
    def commitment_exists
        if not VolunteerCommitment.exists? :user_id => owner_id, :shift_id => shift_id
            errors.add :commitment, "no longer exists" 
        end
    end
    
    def href
        Rails.application.routes.url_helpers.event_shift_path event, shift
    end
    
    def representation
        "Your '#{shift.role}' shift for the '#{event.event_name}' event is tomorrow."
    end
end