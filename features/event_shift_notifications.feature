Feature: Users will receive timely notifications for events and shifts

  As an event creator and/or a volunteer,
  I want to be notified when I have an event or a shift coming up,
  So that I am more likely to show up

  Background: User, Event, Shift, UserActivities, and ActivityTypes in Database
    Given the following users have registered for accounts:
      | email               | username | password     |
      | john_doe@uprise.com | john_doe | hellboy_new  |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy_new"
    And the following events exist:
      | User     | Event Date | Name      | Candidate   | Location |
      | john_doe | 04/8/2100  | Go Batman | Batman      | Gotham   |
      | john_doe | 05/8/2100  | Go Harvey | Harvey Dent | Gotham   |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time | Description   |
      | Go Batman | Tabling  | true      | 4     | 11:00 am   | 11:30 am | Sit all day   |
      | Go Batman | Flyering | true      | 1     | 10:30 pm   | 11:30 pm | Stand all day |
    
  Scenario: Receive event notification 24 hours before a shift
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    When I follow "Join"
    Given I am on the user activity page
    Then I should see "Your 'Tabling' shift for the 'Go Batman' event is tomorrow."

  Scenario: Receive shift notification 24 hours before an event
    Given I am on the home page
    When I follow "Create"
    When I fill in "Event Name" with "Harvey Dent Day"
    And I fill in "Location" with "Gotham"
    And I fill in "Candidate" with "Harvey Dent"
    And I fill in "Description" with "Honor Harvey Dent"
    And I press "Create Event"
    When I am on the user activity page
    Then I should see "Your 'Harvey Dent Day' event is tomorrow."
    
  Scenario: Receive timely event notification for copied events
    Given I am on the page for the "Go Batman" event
    When I follow "Copy Event"
    And I am on the user activity page
    Then I should see "Your 'Go Batman(Copy)' event is tomorrow."
    