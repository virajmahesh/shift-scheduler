Feature: join a shift for an event

  As a user and a volunteer
  So that I can commit to helping out an event
  I want to be able to join a shift

  Background: shifts in database
    Given user test exists with password test1234
    And user test is logged in with password test1234
    Given event 1 exists
    And the following shifts exist
      | event_id | start_time     | end_time       | role     | has_limit | limit |
      | 1        | 11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 4     |
      | 1        | 11:00 4-1-2016 | 11:30 2016-4-1 | flyering | true      | 0     |

    And I am on the event 1 page

  Scenario: I join a shift that is open
    Given I follow "tabling"
    Then I should see "4 volunteers needed"
    When I follow "Join"
    Then I should see "You have been signed up for the shift"
    Then I should be on the shift 1 page
    And I should see "3 volunteers needed"
    And test should have 1 commitments

  Scenario: I try to join a shift that I already joined
    Given I follow "tabling"
    When I follow "Join"
    Then I should see "You have been signed up for the shift"
    And I should see "Leave"
    And I should not see "Join"
    Then I should be on the shift 1 page

  Scenario: I try to join a shift that is full
    Given I follow "flyering"
    When I follow "Join"
    Then I should be on the shift 2 page
    And I should see "Shift already full"