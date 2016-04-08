Feature: Join a shift for an event

  As a user and a volunteer
  I want to be able to join a shift
  So that I can commit to helping out an event

  Background:
    Given the following users have registered for accounts:
      | email                | username  | password |
      | john_doe@uprise.com | john_doe | test1234 |
    And I am on the homepage
    And I log in with username "john_doe" and password "test1234"
    And the following events exist:
      | User      | Event Date | Name          | Candidate | Location |
      | john_doe | 03/03/2016 | Go Batman     | Batman    | Gotham   |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time |
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    |
      | Go Batman | Flyering | true      | 0     | 12:00      | 12:30    |
    And I am on the page for the "Go Batman" event

  Scenario: I join a shift that is open
    When I follow "Tabling"
    Then I should see "0/4 slots filled"
    When I follow "Join"
    Then I should see "You have been signed up for the shift"
    And I should be on the page for the "Tabling" shift for the "Go Batman" event
    And I should see "1/4 slots filled"
    And I should see "Leave"
    And "john_doe" should have 1 volunteer commitment

  Scenario: I try to join a shift that I already joined
    Given "john_doe" has signed up for the "Tabling" shift for the "Go Batman" event
    And I am on the page for the "Tabling" shift for the "Go Batman" event
    Then I should see "Leave"
    And I should not see "Join"

  Scenario: I try to join a shift that is full
    When I follow "Flyering"
    And I should not see "Join"
    And I should not see "Leave"
    And I should see "0/0 slots filled"