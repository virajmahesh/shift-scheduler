class ShiftTimeActivity < UserActivity
    
    def href
        Rails.application.routes.url_helpers.event_shift_path event, shift
    end
    
    def representation
        "Your '#{shift.role}' shift for the '#{event.event_name}' event is tomorrow."
    end
end