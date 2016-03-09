Feature: Users Can See Different Shifts that Are a Part of an Event

  As a user
  I want to see all the different shifts associated with an event
  So that I can select which shifts I want to volunteer for

  Background: shifts in database
    Given user John Doe exists with password hellboy
    And user John Doe is logged in with password hellboy

    Given the following events exists:
      | Id | User    | Date       | Name          | Candidate |
      | 1  | 1       | 03/03/2016 | Go Batman     | Batman    |

    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time |
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    |
      | 1        | Flyering | true      | 0     | 12:00      | 12:30    |


  Scenario: view all shifts
    Given I am on the event 1 page

    Then I should see "11:00 AM to 11:30 AM, Tabling"
    And I should see "12:00 PM to 12:30 PM, Flyering"