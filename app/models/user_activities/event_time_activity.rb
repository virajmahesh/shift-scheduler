class EventTimeActivity < UserActivity

    validate :event_exists
    
    def event_exists
        if not Event.exists? event.id
            errors.add :event, "no longer exists" 
        end
    end
    
    def href
        Rails.application.routes.url_helpers.event_path event
    end

    def representation
        "Your '#{event.event_name}' event is tomorrow."
    end
end