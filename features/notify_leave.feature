Feature: Even Creators Are Notified When Someone Leaves a Shift

  As an event creator
  So that I am kept up to date about that status of my event and so that I can find a replacement for the volunteers that backed out
  I want to be notified when someone leaves an shift I created

  Scenario: as creator, someone in shift leaves shift
    Given I am the creator of an event named Fun Event
    Given the user John Doe exists
    And Fun Event has a shift
    And John Doe is signed up for that shift in Fun Event
    And John Doe leaves that shift in Fun Event
    Then I should be notified

  Scenario: as non-creator, someone in shift leaves shift
    Given I am not the creator of an event named Fun Event
    Given the user John Doe exists
    And Fun Event has a shift
    And John Doe is signed up for that shift in Fun Event
    And John Doe leaves that shift in Fun Event
    Then I should not be notified
