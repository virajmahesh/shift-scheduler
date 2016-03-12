Feature: Users Can See All Future Events on the Home Page

  As a user
  I want to be able to see a list of all future events on the homepage
  so that I can sign up to volunteer for one or more events

  Background:
    Given user test_user exists with password test1234
    And user test_user is logged in with password test1234
    And the following events exists:
      | Id | User    | Date       | Name            | Candidate |
      | 1  | 1       | 03/03/2019 | Go Batman       | Batman    |
      | 2  | 1       | 03/02/2020 | Go Superman     | Batman    |
      | 3  | 1       | 03/03/2010 | Go Robin        | Batman    |


  Scenario: view all future events
    Given I am on the homepage

    Then I should see "Go Batman"

    And I should see "Superman"
    And I should not see "Go Robin"