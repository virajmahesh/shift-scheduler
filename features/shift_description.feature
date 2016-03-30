Feature: Users Can See The Description For A Shift

  As an event creator,
  I want to add descriptions for my shifts
  So that users can get more information regarding the shift they are signing up for.

  Background: User and Event in Database
    Given the following users have registered for accounts:
      | email               | username | password     |
      | john_doe@uprise.com | john_doe | hellboy_new  |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy_new"
    And the following events exist:
      | User    | Event Date | Name          | Candidate | Location |
      | 1       | 03/03/2016 | Go Batman     | Batman    | Gotham   |
    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time | Description
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    | Sit all day
    And I am on the page for the "Go Batman" event

  Scenario: View the description for a shift that already exists
    Given PENDING
    Given I am on the page for the "Go Batman" event
    And I follow "Tabling"
    Then I should see "Sit all day"

  Scenario: Add a description for an event
    Given PENDING
    Given I follow "Add Shift"
    When I fill in "shift_start_time" with "3 pm"
    And I fill in "shift_end_time" with "4 pm"
    And I fill in "shift_role" with "Flyering"
    And I fill in "description" with "Stand all day"
    And I press "Add Shift"
    Then I should be on the page for the "Flyering" shift for the "Go Batman" event
    And I should see "Stand all day"
    
  Scenario: Description is optional
    Given PENDING
    Given I follow "Add Shift"
    When I fill in "shift_start_time" with "3 pm"
    And I fill in "shift_end_time" with "4 pm"
    And I fill in "shift_role" with "Flyering"
    And I press "Add Shift"
    Then I should be on the page for the "Flyering" shift for the "Go Batman" event