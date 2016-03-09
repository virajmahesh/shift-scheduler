Feature: User can Create, edit and delete events

  As a User
  I want to be able to create/edit/delete an event
  So that I can get potential volunteers interested in my cause/campaign.

  Background:
    Given I am on the homepage
    And a user has signed up with the email "john_doe@gmail.com"
    And user john_doe@gmail.com is logged in with password password
    
    And the following events exists:
      | User | Name       | Candidate | Date       |
      | 1    | Go Batman  | Batman    | 03/04/2016 |

  Scenario: attempt to create an event
    When I follow "Create Event"
    Then I should be on the new event page

    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I fill in "Event Date" with "03/03/2016"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"

    Then I should be on the event 2 page
    And I should see "Batman for President"
    And I should see "Gotham"
    And an event named "Batman for President" should exist

  Scenario: attempt to create event with incomplete information
    When I follow "Create Event"
    Then I should be on the new event page

    When I fill in "Location" with "Gotham"
    And I fill in "Event Date" with "03/03/2016"
    And I press "Create Event"

    Then I should be on the new event page
    And I should see "Event name can't be blank"

  Scenario: attempt to delete an event
    Given I am on the event 1 page
    And I press "Delete"

    Then I should be on the home page
    And an event named "Go Batman" should not exist

  Scenario: attempt to edit an event
     When I visit event id 1 page
     And I follow "Edit"

    Then I should be on the edit page for event 1

    When I fill in "Event Date" with "03/04/2016"
    And I press "Save Changes"

    Then the "Event Date" field for event "Go Batman" should be "2016-04-03"