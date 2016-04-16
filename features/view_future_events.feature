Feature: Users Can See All Future Events on the Home Page

  As a user
  I want to be able to see a list of all future events on the homepage
  so that I can sign up to volunteer for one or more events

  Background:
    Given the following users have registered for accounts:
      | email                | username  | password |
      | test_acct@uprise.com | test_acct | test1234 |
    And I log in with username "test_user" and password "test1234"
    And the following events exist:
      | User      | Event Date | Name        | Candidate | Location |
      | test_acct | 03/03/2019 | Go Batman   | Batman    | Gotham   |
      | test_acct | 03/02/2020 | Go Superman | Batman    | Gotham   |
      | test_acct | 03/03/2010 | Go Robin    | Batman    | Gotham   |


  Scenario: View all future events on the homepage, even if not logged in
    Given I am on the homepage
    Then I should see "Go Batman"
    And I should see "Superman"
    And I should not see "Go Robin"
