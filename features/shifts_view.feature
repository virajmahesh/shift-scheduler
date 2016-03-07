Feature: Users Can See Different Shifts that Are a Part of an Event

  As a user
  I want to see all the different shifts associated with an event
  So that I can select which shifts I want to volunteer for

  Background: shifts in database

    Given event 1 exists
    And the following shifts exist

      | event_id | start_time     | end_time       | role     | has_limit | limit | volunteers |
      | 1        | 11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 3     | 1          |
      | 1        | 11:00 4-1-2016 | 11:30 2016-4-1 | flyering | true      | 3     | 2          |


  Scenario: view all shifts
    Given that I am on the event page for event 1
    And that I am signed in
    Then I should see "Shifts of the event are: flyering: from 11:00 to 11:30, tabling: from 11:30 to 12:30"