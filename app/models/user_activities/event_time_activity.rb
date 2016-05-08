class EventTimeActivity < UserActivity

    def href
        Rails.application.routes.url_helpers.event_path event
    end

    def representation
        "Your '#{event.event_name}' event is tomorrow."
    end
end