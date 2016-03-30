Feature: Display The Number Of Users That Have Signed Up For An Event

  As an event creator
  I want to display the number of users that have signed up for an event
  So that I can attract other users and get them to sign up for my event.

  Background:
    Given the following users have registered for accounts:
      | email                | username   | password |
      | test_user@uprise.com | test_user  | test1234 |
      | other_user@uprise.com| other_user | test1234 |
      | main_user@uprise.com | main_user  | test1234 |
    And I log in with username "test_user" and password "test1234"
    And the following events exist:
      | User    | Date       | Name        | Candidate |
      | 1       | 03/03/2019 | Go Batman   | Batman    |
      | 1       | 03/02/2020 | Go Superman | Batman    |
    And the following shifts exist:
      | Event | Start Time | End Time | Role | Has Limit | Limit |
      | 1     | 12:00 PM   | 1:00 PM  | Chef | true      | 10    |
      | 1     | 12:00 PM   | 1:00 PM  | Fix  | true      | 150   |
      | 2     | 12:00 PM   | 1:00 PM  | Sing | true      | 20    |

  Scenario: Only one user signed up for an event
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift  |
      | test_user | Go Batman | 1      |
    Then I should see "1 Volunteer(s) have already signed up to help out with this event"
    And I should not see "Be the first one to join"

  Scenario: Multiple users signed up for different shifts in same event
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift |
      | test_user | Go Batman | 1     |
      | other_user| Go Batman | 2     |
    Then I should see "2 Volunteer(s) have already signed up to help out with this event"
    And I should not see "Be the first one to join"

  Scenario: view multiple users signed up for different shifts in same events, non-unique
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift |
      | test_user | Go Batman | 1     |
      | test_user | Go Batman | 2     |
    Then I should see "1 Volunteer(s) have already signed up to help out with this event"
