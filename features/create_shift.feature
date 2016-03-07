Feature: User can Create, edit and delete shifts

  As a User
  I want to create/edit/delete one or more shifts for each Event
  So that I can break and Event down into subtasks and organize volunteers by skill type.

  Background:
    Given that I am on the "Batman for president" event page
    And that I am the event creator

  Scenario: attempt to create a shift
    When I click the Add Shift button
    Then I should be on the create shift page

    When I enter "1:00 PM" in the start time field
    And I eneter " 2:00 PM" in the end time field
    And I enter "set up" in the role field
    And I check no limit
    And I click 'Add Shift'

    Then I should be on the "Batman for president" event page
    And I should see the set up shift under event shifts

  Scenario: attempt to create event with incomplete information
    When I click the Add Shift button
    Then I should be on the create shift page

    When I enter "1:00 PM" in the start time field
    And I eneter " 2:00 PM" in the end time field
    And I enter "set up" in the role field
    And I click 'Add Shift'

    Then I should be on the create shift page
    And I should see 'Error! Please fill in all the required information' on the page

  Scenario: attempt to delete a shift
    When I chose the 'set up' shift
    Then I should see the delete button

    When I click on the delete button
    Then I should see a message saying "event deleted"
    And I should not see 'set up' shift on the page

  Scenario: attempt to edit an event
    When I click on 'set up' shift
    Then I should see the edit button

    When I click the edit button
    Then I should be on the edit shift page

    When I enter "3:00 PM" in the end time field
    And I click save changes

    Then I should be on the "Batman for president" event page
    And I should see "3:00 PM" as the end time of the event
