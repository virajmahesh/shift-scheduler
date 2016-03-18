Feature: Display The Number Of Users That Have Signed Up For An Event

  As an event creator
  I want to display the number of users that have signed up for an event
  So that I can attract other users and get them to sign up for my event.

  Background:
    Given the following users have registered for accounts:
      | email                | username  | password |
      | test_user@uprise.com | test_user | test1234 |
      | other_user@uprise.com| other_user| test1234 |
      | main_user@uprise.com | main_user | test1234 |
    And I log in with username "test_user" and password "test1234"
    And other logs in with username "other_user" and password "test1234"
    And main logs in with username "main_user" and password "test1234"

    And the following events exist:
      | User    | Date       | Name            | Candidate |
      | 1       | 03/03/2019 | Go Batman       | Batman    |
      | 1       | 03/02/2020 | Go Superman     | Batman    |
    And the following shifts exist:
      | Event | Start Time | End Time | Role |
      | 1     | 12:00      | 1:00     | Chef |
      | 1     | 12:00      | 1:00     | Fix  |
      | 2     | 12:00      | 1:00     | Sing |

  Scenario: view one user signed up for one event, no one signed up for other
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift  |
      | test_user | Go Batman | 1      |
    Then I should see "1 Volunteer(s) have already signed up to help out with this event"
    And I should see "Be the first one to join"

  Scenario: view multiple users signed up for different shifts in same event
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift |
      | test_user | Go Batman | 1     |
      | other_user| Go Batman | 2     |
    Then I should see "2 Volunteer(s) have already signed up to help out with this event"

  Scenario: view multiple users signed up for different shifts in same events, non-unique
    Given I am on the homepage
    And the following volunteer commitments exist:
      | User      | Event     | Shift |
      | test_user | Go Batman | 1     |
      | test_user | Go Batman | 2     |

    Then I should see "1 Volunteer(s) have already signed up to help out with this event"
