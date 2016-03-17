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
      | 1       | 03/03/2018 | Go Batman     | Batman    |
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

  Scenario: Attempt to create a shift without a start time
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    And I fill in "End Time" with "2:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should be on the page for the "Go Batman" event
    And I should see "Start Time Can't Be Blank"

  Scenario: Attempt to create a shift without an end time
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "1:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should be on the page for the "Go Batman" event
    And I should see "End Time Can't Be Blank"

  Scenario: Attempt to create a shift without an end time
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "1:00 PM"
    And I fill in "End Time" with "2:00 PM"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should see "Role can't be blank"

  Scenario: Attempt to create a shift without a limit
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "1:00 PM"
    And I fill in "End Time" with "2:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I press "Add Shift"
    Then a shift with role "Set Up" should exist
    And I should be on the page for the "Set Up" shift for the "Go Batman" event
    And I should see "1:00 PM - 2:00 PM, Setup"

  Scenario: Indicate that shift has a limit but don't enter a limit
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "1:00 PM"
    And I fill in "End Time" with "2:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should be on the new shift page
    And I should see "Please enter the number of volunteers needed"

  Scenario: Attempt to modify a shift when logged out
    Given PENDING
    Given I am on the homepage
    Then I should see "Go Batman"
    When I follow "Logout"
    Then I should be on the homepage
    And I should not see "john_doe"
    When I follow "Go Batman"
    And I follow "Tabling"
    Then I should not see "Edit"
    And I should not see "Delete"

  Scenario: Attempt to modify a shift when logged in as user that did not create the event
    Given PENDING
    Given I follow "Logout"
    And I log in with username "jane_doe" and password "jane_doe_password"
    Then I should be on the homepage
    When I follow "Go Batman"
    And I follow "Tabling"
    Then I should not see "Edit"
    And I should not see "Delete"

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
