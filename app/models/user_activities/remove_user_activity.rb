class RemoveUserActivity < UserActivity

    def href
      event_path event
    end

    def representation
      "You have been removed from the '#{shift.role}' shift for the '#{event.event_name}' event."
    end
end