class EventTimeActivity < UserActivity

    def href
      event_path event
    end

    def representation
      "Your '#{event.event_name}' event is tomorrow."
    end
end