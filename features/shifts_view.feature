Feature: Users Can See Different Shifts that Are a Part of an Event

  As a user
  I want to see all the different shifts associated with an event
  So that I can select which shifts I want to volunteer for

  Background: shifts in database
    Given the following users have registered for accounts:
      | email               | username | password  |
      | john_doe@uprise.com | john_doe | hellboy1  |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy1"
    And the following events exist:
      | User     | Event Date | Name          | Candidate | Location |
      | john_doe | 03/03/2016 | Go Batman     | Batman    | Gotham   |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time |
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    |
      | Go Batman | Flyering | true      | 0     | 12:00      | 12:30    |

  Scenario: View all shifts for an event
    Given I am on the page for the "Go Batman" event
    Then I should see "11:00 AM to 11:30 AM, Tabling"
    And I should see "12:00 PM to 12:30 PM, Flyering"