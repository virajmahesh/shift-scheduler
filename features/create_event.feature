Feature: User can Create, edit and delete events

  As a User
  I want to be able to create/edit/delete an event
  So that I can get potential volunteers interested in my cause/campaign.

  Background:
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And the following events exist:
      | User     | Name       | Location  | Candidate | Event Date |
      | john_doe | Go Batman  | Gotham    | Batman    | 03/04/2018 |
    And the following issues exist:
      | Description       |
      | Human Trafficking |
      | Community         |
      | Animal Rights     |
    And the following event issues exist:
    | Event     | Issue             |
    | Go Batman | Human Trafficking |
    | Go Batman | Community         |
    And I am on the homepage
    And I log in with username "john_doe" and password "john_doe_password"

  Scenario: Attempt to create an event
    When I follow "Create"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the page for the "Batman for President" event
    And I should see "Batman for President"
    And I should see "Gotham"
    And an event named "Batman for President" should exist
 
  Scenario: Attempt to create event without a name
    When I follow "Create"
    Then I should be on the new event page
    When I fill in "Location" with "Gotham"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    And I should see "Event name can't be blank"

  Scenario: Attempt to create event without an event date
    When I follow "Create"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I fill in "event[event_date]" with " "
    And I press "Create Event"
    Then an event named "Batman for President" should not exist
    And I should see "Event date can't be blank"
    
  Scenario: Attempt to create without location
    When I follow "Create"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    And I should see "Location can't be blank"
    And an event named "Batman for President" should not exist

  Scenario: Attempt to create without candidate
    When I follow "Create"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Location" with "Gotham"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    And I should see "Candidate can't be blank"
    And an event named "Batman for President" should not exist
    
  Scenario: Attempt to modify an event when logged out
    When I follow "Logout"
    Then I should be on the homepage
    And I should not see "john_doe"
    When I follow "Go Batman"
    Then I should not see "Edit Event"
    And I should not see "Delete Event"
    And I should not see "Add Shift"

  Scenario: Attempt to modify an event when logged in as a user that did not create the event
    When I follow "Logout"
    Then I should be on the homepage
    And I should not see "john_doe"
    And I log in with username "jane_doe" and password "jane_doe_password"
    Then I should be on the homepage
    When I follow "Go Batman"
    Then I should not see "Edit Event"
    And I should not see "Delete Event"

  Scenario: Attempt to delete an event
    Given I am on the page for the "Go Batman" event
    And I follow "Delete Event"
    Then I should be on the home page
    And an event named "Go Batman" should not exist

  Scenario: Attempt to edit an event
    Given I am on the page for the "Go Batman" event
    And I follow "Edit Event"
    Then I should be on the edit page for the "Go Batman" event
    When I fill in "event[event_date]" with "03/04/2019"
    And I press "Save Changes"
    Then I should be on the page for the "Go Batman" event
    And I should see "April 3, 2019"
    And I should not see "April 3, 2016"

  Scenario: If form input is partially invalid, valid input should be preserved
    When I follow "Create"
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Candidate" with "Batman"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should see "Batman for President" in "Event Name"
    And I should see "Batman" in "Candidate"
    And I should see "A fund raiser for Batman" in "Description"

  Scenario: Add issues to an event
    When I follow "Create"
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Candidate" with "Batman"
    And I fill in "Location" with "Gotham"
    And I fill in "event[event_date]" with "03/03/2016"
    And I fill in "Description" with "A fund raiser for Batman"
    And I select the following issues: "Human Trafficking, Community"
    And I press "Create Event"
    Then the "Batman for President" event should have "Human Trafficking" as an issue
    And the "Batman for President" event should have "Community" as an issue
    And I should be on the page for the "Batman for President" event
    And I should see "Human Trafficking"
    And I should see "Community"
    And I should not see "Animal Rights"

  Scenario: Copy an event when logged in as event creator
    Given I am on the page for the "Go Batman" event
    When I follow "Copy Event"
    Then I should be on the page for the "Go Batman(Copy)" event
    And I should see "Event successfully copied"
    And I should see "Created By: john_doe"
    And I should see "Human Trafficking, Community"

  Scenario: Copy an event when logged in as a user other than event creator
    Given I follow "Logout"
    And I log in with username "jane_doe" and password "jane_doe_password"
    And I am on the page for the "Go Batman" event
    When I follow "Copy Event"
    Then I should be on the page for the "Go Batman(Copy)" event
    And I should see "Event successfully copied"
    And I should see "Created By: jane_doe"
    And I should see "Human Trafficking, Community"

  Scenario: Copy an event when logged out
    Given I follow "Logout"
    And I am on the page for the "Go Batman" event
    Then I should not see "Copy Event"