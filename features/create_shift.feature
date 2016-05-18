Feature: User can Create, edit and delete shifts

  As a User
  I want to create/edit/delete one or more shifts for each Event
  So that I can break and Event down into subtasks and organize volunteers by skill type.
  I want the text box for the event description to be larger so that I can have craft a better description for my event.


  Background:
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And I am on the homepage
    And I log in with username "john_doe" and password "john_doe_password"
    And the following events exist:
      | User     | Name       | Location  | Candidate | Event Date |
      | john_doe | Go Batman  | Gotham    | Batman    | 03/04/2018 |
      | john_doe | Go Joker   | Gotham    | Joker     | 03/05/2017 |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time |
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    |
      | Go Batman | Flyering | true      | 0     | 12:00      | 12:30    |
    And the following skills exist:
      | Description |
      | Walking     |
      | Spanish     |

  Scenario: Attempt to create a shift
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    And the page should contain a multiline textbox
    When I select "1:00 PM" as the shift "Start Time"
    And I select "3:00 PM" as the shift "End Time"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should exist
    Then I should be on the page for the "Set Up" shift for the "Go Batman" event
    And I should see "Set Up"


  Scenario: Attempt to create a shift without a role
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    When I select "1:00 PM" as the Shift "Start Time"
    And I select "3:00 PM" as the Shift "End Time"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should see "Role can't be blank"

  Scenario: Attempt to create a shift without a limit
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    When I select "1:00 PM" as the Shift "Start Time"
    And I select "3:00 PM" as the Shift "End Time"
    And I fill in "Shift Role" with "Set Up"
    And I press "Add Shift"
    Then a shift with role "Set Up" should exist
    And I should be on the page for the "Set Up" shift for the "Go Batman" event

  Scenario: Indicate that shift has a limit but don't enter a limit
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    When I select "1:00 PM" as the Shift "Start Time"
    And I select "3:00 PM" as the Shift "End Time"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I press "Add Shift"
    Then a shift with role "Set Up" should not exist
    And I should be on the new shift page
    And I should see "Please enter the number of volunteers needed"

  Scenario: Attempt to modify a shift when logged out
    Given I am on the homepage
    Then I should see "Go Batman"
    When I follow "Logout"
    Then I should be on the homepage
    And I should not see "john_doe"
    When I follow "Go Batman"
    And I follow "Tabling"
    Then I should not see "Edit Shift"
    And I should not see "Delete Shift"

  Scenario: Attempt to modify a shift when logged in as user that did not create the event
    Given I follow "Logout"
    And I log in with username "jane_doe" and password "jane_doe_password"
    Then I should be on the homepage
    When I follow "Go Batman"
    And I follow "Tabling"
    Then I should not see "Edit Shift"
    And I should not see "Delete Shift"
    And I should not see "Leave"
    And I should see "Join"

  Scenario: Attempt to modify a shift when logged out
    Given I follow "Logout"
    Then I should be on the homepage
    When I follow "Go Batman"
    And I follow "Tabling"
    Then I should not see "Edit Shift"
    And I should not see "Delete Shift"
    And I should not see "Leave"
    And I should not see "Join"

  Scenario: Attempt to delete a shift
    Given I am on the page for the "Go Batman" event
    Then I should see "Tabling"
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    And I press "Delete Shift"
    Then I should be on the page for the "Go Batman" event
    And I should see "Shift deleted"
    And a shift with role "Flyering" should exist
    And a shift with role "Tabling" should not exist
    And I should see "Flyering"
    And I should not see "Tabling" within "#shifts"

  Scenario: Attempt to edit a shift
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    And I follow "Edit Shift"
    Then I should be on the edit page for the "Tabling" shift for the "Go Batman" event
    And the page should contain a multiline textbox
    And I should see "Shift Description"
    When I select "3:00 PM" as the Shift "End Time"
    And I press "Save Changes"
    Then I should be on the page for the "Tabling" shift for the "Go Batman" event
    And I should see "3:00 PM"
    And I should not see "11:30 AM"
    
  Scenario: Add issues to a shift while creating it
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    And the page should contain a multiline textbox
    When I select "1:00 PM" as the shift "Start Time"
    And I select "3:00 PM" as the shift "End Time"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I select the following skills: "Walking, Spanish"
    And I press "Add Shift"
    Then a shift with role "Set Up" should exist
    Then I should be on the page for the "Set Up" shift for the "Go Batman" event
    And I should see "Set Up"
    And the "Set Up" shift of the "Go Batman" event should have "Walking" as a skill
    And the "Set Up" shift of the "Go Batman" event should have "Spanish" as a skill

  Scenario: Add issues to a shift while editing it
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    And I follow "Edit Shift"
    Then I should be on the edit page for the "Tabling" shift for the "Go Batman" event
    And I select the following skills: "Walking, Spanish"
    And I press "Save Changes"
    Then a shift with role "Tabling" should exist
    And I should be on the page for the "Tabling" shift for the "Go Batman" event
    And I should see "Tabling"
    And the "Tabling" shift of the "Go Batman" event should have "Walking" as a skill
    And the "Tabling" shift of the "Go Batman" event should have "Spanish" as a skill
    And I should see "Walking"
    And I should see "Spanish"

  Scenario: Delete issues from a shift while editing it
    Given the following shift skills exist:
      | Event     | Shift    | Skill   |
      | Go Batman | Tabling  | Walking |
      | Go Batman | Tabling  | Spanish |
    And I am on the page for the "Tabling" shift for the "Go Batman" event
    And I follow "Edit Shift"
    Then I should be on the edit page for the "Tabling" shift for the "Go Batman" event
    And I remove the following skills: "Walking, Spanish"
    And I press "Save Changes"
    Then a shift with role "Tabling" should exist
    And I should be on the page for the "Tabling" shift for the "Go Batman" event
    And I should see "Tabling"
    And the "Tabling" shift of the "Go Batman" event should not have "Walking" as a skill
    And the "Tabling" shift of the "Go Batman" event should not have "Spanish" as a skill
    And I should not see "Walking"
    And I should not see "Spanish"

  Scenario: User is notified about shift with matching skills
    Given the following user skills exist:
    | User     | Skill   |
    | john_doe | Walking |
    And I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page for the "Go Batman" event
    When I select "1:00 PM" as the shift "Start Time"
    And I select "3:00 PM" as the shift "End Time"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I select the following skills: "Walking"
    And I press "Add Shift"
    And I follow "Notifications"
    Then I should see "Your skills are needed for the 'Set Up' shift of the 'Go Batman' event."

  Scenario: If start time after end time, valid input should be preserved
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "2:00 PM"
    And I fill in "End Time" with "1:00 PM"
    And I fill in "Shift Role" with "Set Up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"
    Then I should be on the new shift page
    And I should not see "2:00 PM"
    And I should not see "1:00 PM"
    And I should see "Set Up"
    And I should see "5"

  Scenario: If incorrectly formatted times, valid input should be preserved
    Given PENDING
    Given I am on the page for the "Go Batman" event
    When I follow "Add Shift"
    Then I should be on the new shift page
    When I fill in "Start Time" with "10:99 PM"
    And I fill in "End Time" with "Whenever"
    And I fill in "Shift Role" with "Tabling"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "543"
    And I press "Add Shift"
    Then I should be on the new shift page
    And I should not see "10:99 PM"
    And I should not see "Whenever"
    And I should see "Tabling"
    And I should see "543"
