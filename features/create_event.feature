Feature: User can Create, edit and delete events

  As a User
  I want to be able to create/edit/delete an event
  So that I can get potential volunteers interested in my cause/campaign.

  Background:
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And I am on the homepage
    And I log in with username "john_doe" and password "john_doe_password"
    And the following events exist:
      | User | Name       | Candidate | Date       |
      | 1    | Go Batman  | Batman    | 03/04/2016 |

  Scenario: Attempt to create an event
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I fill in "Event Date" with "03/03/2016"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the page for the "Batman for President" event
    And I should see "Batman for President"
    And I should see "Gotham"
    And an event named "Batman for President" should exist

  Scenario: Attempt to create event with incomplete information
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Location" with "Gotham"
    And I fill in "Event Date" with "03/03/2016"
    And I press "Create Event"
    Then I should be on the new event page
    And I should see "Event name can't be blank"

  Scenario: Attempt to delete an event
    Given I am on the page for the "Go Batman" event
    And I press "Delete"
    Then I should be on the home page
    And an event named "Go Batman" should not exist

  Scenario: Attempt to edit an event
    Given I am on the page for the "Go Batman" event
    And I follow "Edit"
    Then I should be on the edit page for event 1
    When I fill in "Event Date" with "03/04/2019"
    And I press "Save Changes"
    Then I should be on the page for the "Go Batman" event
    And I should see "April 3, 2019"
    And I should not see "03/04/2016"