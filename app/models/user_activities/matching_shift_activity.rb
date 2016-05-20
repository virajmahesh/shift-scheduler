class MatchingShiftActivity < UserActivity

  def href
    event_shift_path event, shift
  end

  def representation
    "Your skills are needed for the '#{shift.role}' shift of the '#{event.event_name}' event."
  end
end