Feature: leave a shift for an event

  As a user signed up for a shift
  So that I can cancel if I can't make it
  I want to be able to leave a shift

  Background: Shifts in database
    Given user test_user exists with password test1234
    And user test_user is logged in with password test1234

    And the following events exists:
      | Id | User    | Date       | Name          | Candidate |
      | 1  | 1       | 03/03/2016 | Go Batman     | Batman    |

    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time |
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    |
      | 1        | Flyering | true      | 0     | 12:00      | 12:30    |

    And I am on the event 1 page

  Scenario: I leave a shift I signed up for
    When I follow "Tabling"
    And I follow "Join"
    Then I should see "Leave"
    And I should see "1/4 slots filled"

    When I follow "Leave"
    Then I should be on the shift 1 page
    And I should see "0/4 slots filled"
    And I should see "You have left the shift"

  Scenario: I try to leave a shift I did not sign up for
    When I follow "Tabling"
    Then I should not see "Leave"