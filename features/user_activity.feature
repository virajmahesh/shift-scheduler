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
    And the following activity_types exist:
      | Activity                    |
      | User has joined shift:      |
      | User has left shift:        |
      | Shift is full:              |
      | You have an event tomorrow: |
      | You have a shift tomorrow:  |

  Scenario: View notifications through the home page
    Given the following user_activities exist:
      | User | Activity | Shift |
      | 1    | 1        | 1     |
      | 1    | 2        | 1     |
    And I am on the home page
    When I follow "Notifications"
    Then I should see "User has joined shift: Tabling"
    And I should see "User has left shift: Tabling"
    
  Scenario: Should see no notifications if nothing happened
    Given I am on the user activity page
    Then I should not see "User has joined shift:"
    And I should not see "User has left shift:"
    And I should not see "Shift is full:"

  Scenario: Joining a shift should generate a notification
    Given I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Join"
    And I am on the user activity page
    Then I should see "User has joined shift: Flyering"
    
  Scenario: Leaving a shift should generate a notification
    Given "john_doe" has signed up for the "Flyering" shift for the "Go Batman" event
    And I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Leave"
    And I am on the user activity page
    Then I should see "User has left shift: Flyering"
    
  Scenario: A shift filling up should generate a notification
    Given I am on the page for the "Flyering" shift for the "Go Batman" event
    When I follow "Join"
    And I am on the user activity page
    Then I should see "Shift is full: Flyering"