class MatchingShiftActivity < UserActivity

  def href
    event_shift_path event, shift
  end

  def representation
    "Your skills are needed for the '#{self.shift.role}' shift of the '#{self.event.event_name}' event"
  end
end