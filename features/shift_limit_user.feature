Feature: Event Creators Can limit the number of users that can sign up for a shift

  As an event creator
  I want to be able to limit the number of people that can sign up for a shift
  so that I don’t have too many volunteers for the same shift

  Background:
    Given the following users have registered for accounts:
      | email                | username  | password |
      | test_user@uprise.com | test_user | test1234 |
      | jane_doe@uprise.com  | jane_doe  | password |
      | john_doe@uprise.com  | john_doe  | password |
    And I am on the homepage
    And I log in with username "john_doe" and password "password"
    And the following events exist:
      | User    | Date       | Name          | Candidate |
      | 1       | 03/03/2016 | Go Batman     | Batman    |
    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time |
      | 1        | Tabling  | true      | 2     | 11:00      | 11:30    |
      | 1        | Flyering | true      | 0     | 12:00      | 12:30    |
    And I am on the page for the "Go Batman" event

  Scenario: Attempt to sign up for shift that has space
    Given "test_user" has signed up for the "Tabling" shift for the "Go Batman" event
    And I am on the page for the "Tabling" shift for the "Go Batman" event
    When I follow "Join"
    Then the "Tabling" shift for the "Go Batman" event should have 2 volunteers
    And "john_doe" should have 1 volunteer commitments
    And I should see "You have been signed up"

  Scenario: attempt to sign up for shift that is at capacity
    Given "test_user" has signed up for the "Tabling" shift for the "Go Batman" event
    And "jane_doe" has signed up for the "Tabling" shift for the "Go Batman" event
    And I am on the page for the "Tabling" shift for the "Go Batman" event
    Then I should not see "Join"
    And I should not see "Leave"
    And I should see "2/2 slots filled"
