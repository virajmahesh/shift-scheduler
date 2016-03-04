Feature: Event Creators Are Notified By When Someone Joins a Shift

  As an event creator
  So that I am kept up to date about the status of my event
  I want to be notified when someone joins a shift

Scenario: as creator of an event, someone joins a shift
  Given I am the creator of an event named Fun Event
  Given the user John Doe exists
  And Fun Event has a shift
  And John Doe signs up for that shift in Fun Event
  Then I should be notified

Scenario: as creator of an event, someone leaves a shift
  Given I am not the creator of an event named Fun Event
  Given the user John Doe exists
  And Fun Event has a shift
  And John Doe signs up for that shift in Fun Event
  Then I should not be notified
