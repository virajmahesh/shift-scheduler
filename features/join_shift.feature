Feature: Join a shift for an event

  As a user and a volunteer
  I want to be able to join a shift
  So that I can commit to helping out an event

  Background: shifts in database
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

  Scenario: I join a shift that is open
    When I follow "Tabling"
    Then I should see "0/4 slots filled"

    When I follow "Join"
    Then I should see "You have been signed up for the shift"
    And I should be on the shift 1 page
    And I should see "1/4 slots filled"
    And test_user should have 1 commitment

  Scenario: I try to join a shift that I already joined
    When I follow "Tabling"
    Then I should see "0/4 slots filled"

    When I follow "Join"
    Then I should see "You have been signed up for the shift"

    And I should see "Leave"
    And I should not see "Join"
    And I should be on the shift 1 page

  Scenario: I try to join a shift that is full
    When I follow "Flyering"
    Then I should be on the shift 2 page
    And I should not see "Join"
    And I should not see "Leave"
    And I should see "0/0 slots filled"