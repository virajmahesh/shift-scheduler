Feature: leave a shift for an event
  
  As a user signed up for a shift
  So that I can cancel if I can't make it
  I want to be able to leave a shift

Background: shifts in database
  
    Given event 1 exists
    And the following shifts exist

    | event_id | start_time    | end_time       | role     | has_limit | limit | volunteers |
    | 1        |11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 4     | 0          |
    | 1        |11:00 4-1-2016 | 11:30 2016-4-1 | flyering | true      | 5     | 5          |

    And I am signed up for the event 1 shift
    And I am on the event 1 shift page
    
Scenario: I leave a shift I signed up for
  Given I follow "tabling_shift"
  When I press "leave_tabling"
  Then I should be on the event 1 shift page
  And I should see "You have left the tabling shift"
  
Scenario: I try to leave a shift I did not sign up for
  Given I follow "flyering_shift"
  When I press "leave_flyering"
  Then I should be on the event 1 shift page
  And I should see "You are not signed up for this shift"