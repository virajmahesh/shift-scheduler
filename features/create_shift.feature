Feature: User can Create, edit and delete shifts

  As a User
  I want to create/edit/delete one or more shifts for each Event
  So that I can break and Event down into subtasks and organize volunteers by skill type.

  Background:
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And I am on the homepage
    And I log in with username "john_doe" and password "john_doe_password"
    And the following events exist:
      | User    | Date       | Name          | Candidate |
      | 1       | 03/03/2016 | Go Batman     | Batman    |
    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time |
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    |
      | 1        | Flyering | true      | 0     | 12:00      | 12:30    |

  Scenario: Attempt to create a shift
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "1:00 PM"
    And I fill in "End Time" with "2:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should exist

  Scenario: Attempt to delete a shift
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    And I press "Delete"
    Then I should be on the page for the "Go Batman" event
    And a shift with role "Flyering" should exist
    And a shift with role "Tabling" should not exist
    And I should see "Flyering"
    And I should not see "Tabling "

  Scenario: Attempt to edit a shift
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    And I follow "Edit"
    Then I should be on the edit page for the "Tabling" shift for the "Go Batman" event
    When I fill in "End Time" with "3:00 PM"
    And I press "Save Changes"
    Then I should be on the page for the "Tabling" shift for the "Go Batman" event
