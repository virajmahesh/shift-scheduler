Feature: join a shift for an event
  
  As a user and a volunteer
  So that I can commit to helping out an event
  I want to be able to join a shift

Background: shifts in database
  
    Given event 1 exists
    And the following shifts exist

    | event_id | start_time    | end_time       | role     | has_limit | limit | volunteers |
    | 1        |11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 4     | 0          |
    | 1        |11:00 4-1-2016 | 11:30 2016-4-1 | flyering | true      | 5     | 5          |
    
    And I am signed in
    And I am on the event 1 shift page
    
Scenario: I join a shift that is open
  Given I press "tabling"
  When I press "join_tabling"
  Then I should see "joined tabling shift"
  And I should be on the event 1 shift page
  And the number of volunteers should be 1
  
Scenario: I try to join a shift that I already joined
  Given I press "tabling"
  When I press "join_tabling"
  And I press "join_tabling"
  Then I should be on the event 1 shift page
  And I should see "Already joined this shift"
  
Scenario: I try to join a shift that is full
  Given I press "flyering"
  When I press "join_flyering"
  Then I should be on the event 1 shift page
  And I should see "Event shift is full"