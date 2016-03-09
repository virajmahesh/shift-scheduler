Feature: User can Create, edit and delete shifts

  As a User
  I want to create/edit/delete one or more shifts for each Event
  So that I can break and Event down into subtasks and organize volunteers by skill type.

  Background:
    Given a user has signed up with the email "john_doe@gmail.com"
    And user john_doe@gmail.com is logged in with password password

    And the following events exists:
      | Id | User    | Date       | Name          | Candidate |
      | 1  | 1       | 03/03/2016 | Go Batman     | Batman    |

    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time |
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    |
      | 1        | Flyering | true      | 0     | 12:00      | 12:30    |



  Scenario: attempt to create a shift
    When I visit event id 1 page
    When I follow "Add Shift"
    Then I should be on the new shift page

    When I fill in "Start Time" with "1:00 PM"
    And I fill in "End Time" with "2:00 PM"
    And I fill in "Shift Role" with "set up"
    And I check "Shift Has Limit"
    And I fill in "Shift Limit" with "5"
    And I press "Add Shift"

    Then a shift named "set up" should exist

  Scenario: attempt to delete a shift
    When I visit shift id 1 page
    And I press "Delete"

    Then I should be on the home page
    And a shift named "set up" should not exist

  Scenario: attempt to edit a shift
    When I visit shift id 1 page
    And I follow "Edit"
    Then I should be on the edit page for shift 1

    When I fill in "End Time" with "3:00 PM"
    And I press "Save Changes"

    Then I should be on the homepage
