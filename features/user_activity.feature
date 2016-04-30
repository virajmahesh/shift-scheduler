Feature: Users have a way to view their most recent notifications

  As an event creator,
  I want to be notified when people join and leave shifs, and when they fill up
  So that I can better learn

  Background: User, Event, Shift, UserActivities, and ActivityTypes in Database
    Given the following users have registered for accounts:
      | email               | username | password    |
      | john_doe@uprise.com | john_doe | hellboy_new |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy_new"
    And the following events exist:
      | User     | Event Date | Name      | Candidate | Location |
      | john_doe | 03/03/2016 | Go Batman | Batman    | Gotham   |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time | Description   |
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    | Sit all day   |
      | Go Batman | Flyering | true      | 1     | 10:30      | 11:30    | Stand all day |

  Scenario: View notifications through the home page
    Given the following user_activities exist:
      | Owner |User | Type          | Shift | Event |
      | 1     | 1   | JoinActivity  | 1     | 1     |
      | 1     | 1   | LeaveActivity | 1     | 1     |
    And I am on the home page
    When I follow "Notifications"
    Then I should see "User 'john_doe' has joined the 'Tabling' shift for the 'Go Batman' event."
    And I should see "User 'john_doe' has left the 'Tabling' shift for the 'Go Batman' event."
    
  Scenario: Should see no notifications if nothing happened
    Given I am on the user activity page
    Then I should not see "User 'john_doe' has joined the 'Tabling' shift for the 'Go Batman' event."
    And I should not see "User 'john_doe' has joined the 'Flyering' shift for the 'Go Batman' event."
    And I should not see "The 'Tabling' shift for the 'Go Batman' event is full."

  Scenario: Joining a shift should generate a notification
    Given I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Join"
    And I am on the user activity page
    Then I should see "User 'john_doe' has joined the 'Flyering' shift for the 'Go Batman' event."
    
  Scenario: Leaving a shift should generate a notification
    Given "john_doe" has signed up for the "Flyering" shift for the "Go Batman" event
    And I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Leave"
    And I am on the user activity page
    Then I should see "User 'john_doe' has left the 'Flyering' shift for the 'Go Batman' event."
    
  Scenario: A shift filling up should generate a notification
    Given I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Join"
    And I am on the user activity page
    Then I should see "The 'Flyering' shift for the 'Go Batman' event is full."
    
  Scenario: Users can dismiss/delete their notifications
    Given the following user_activities exist:
      | Owner |User | Type          | Shift | Event |
      | 1     | 1   | JoinActivity  | 1     | 1     |
      | 1     | 1   | LeaveActivity | 1     | 1     |
    And I am on the user activity page
    When I follow "delete_activity_1"
    Then I should not see "User 'john_doe' has joined the 'Tabling' shift for the 'Go Batman' event."
    And I should see "User 'john_doe' has left the 'Tabling' shift for the 'Go Batman' event."