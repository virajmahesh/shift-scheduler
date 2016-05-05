class UserJoinActivity < UserActivity
    
    def href
        Rails.application.routes.url_helpers.event_shift_path event, shift
    end
    
    def representation
        "You have joined the '#{shift.role}' shift for the '#{event.event_name}' event."
    end
end