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
      | User | Name       | Location  | Candidate | Event Date       |
      | 1    | Go Batman  | Gotham    | Batman    | 03/04/2018       |

  Scenario: Attempt to create an event
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I select "03/03/2016" as the "Event Date"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the page for the "Batman for President" event
    And I should see "Batman for President"
    And I should see "Gotham"
    And an event named "Batman for President" should exist
 
  Scenario: Attempt to create event without a name
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Location" with "Gotham"
    And I select "03/03/2016" as the "Event Date"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the new event page
    And I should see "Event name can't be blank"

  Scenario: Attempt to create event without an event date
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I fill in "Location" with "Gotham"
    And I press "Create Event"
    Then an event named "Batman for President" should not exist
    Then I should be on the new event page
    And I should see "Event date can't be blank"
    
  Scenario: Attempt to create without location
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I select "03/03/2016" as the "Event Date"
    And I fill in "Candidate" with "Batman"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the new event page
    And I should see "Location can't be blank"

  Scenario: Attempt to create without candidate
    When I follow "Create Event"
    Then I should be on the new event page
    When I fill in "Event Name" with "Batman for President"
    And I select "03/03/2016" as the "Event Date"
    And I fill in "Location" with "Gotham"
    And I fill in "Description" with "A fund raiser for Batman"
    And I press "Create Event"
    Then I should be on the new event page
    And I should see "Candidate can't be blank"
    
  Scenario: Attempt to modify an event when logged out
    Given PENDING
    When I follow "Logout"
    Then I should be on the homepage
    And I should not see "john_doe"
    When I follow "Go Batman"
    Then I should not see "Edit Event"
    And I should not see "Delete Event"
    And I should not see "Add Shift"