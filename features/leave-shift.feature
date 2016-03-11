Feature: leave a shift for an event

  As a user signed up for a shift
  So that I can cancel if I can't make it
  I want to be able to leave a shift

  Background: shifts in database
    Given user test exists with password test1234
    And user test is logged in with password test1234
    Given event 1 exists
    And the following shifts exist
      | event_id | start_time     | end_time       | role     | has_limit | limit |
      | 1        | 11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 4     |
      | 1        | 11:00 4-1-2016 | 11:30 2016-4-1 | flyering | true      | 0     |

    And test signs up for shift 1
    And am on the event 1 page

  Scenario: I leave a shift I signed up for
    Given I follow "tabling"
    When I follow "Leave"
    Then I should be on the shift 1 page
    And I should see "You have left the shift"

  Scenario: I try to leave a shift I did not sign up for
    Given I follow "tabling"
    And I follow "Leave"
    When I go to the shift 1 page
    Then I should not see "Leave"
    And I should see "Join"
    When I go to the shift 2 page
    Then I should not see "Leave"
    And I should see "Join"