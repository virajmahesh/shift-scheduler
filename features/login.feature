Feature: Users Can Login With Their Credentials

  As a user
  I want to login with my credentials (email/username + password)
  So that I can prevent unauthorized access to my account

  Background: users that have registered
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And I am on the homepage


  Scenario: attempt to login with email and password
    When I follow "Login"
    Then I should be on the login page
    When I fill in "Email/Username" with "john_doe@uprise.com"
    And I fill in "Password" with "john_doe_password"
    And I press "Login"
    Then I should be on the homepage
    And I should see "john_doe"


  Scenario: attempt to login with username and password
    When I follow "Login"
    Then I should be on the login page
    When I fill in "Email/Username" with "jane_doe"
    And I fill in "Password" with "jane_doe_password"
    And I press "Login"
    Then I should be on the homepage
    And I should see "jane_doe"


  Scenario: attempt to login with incorrect username
    When I follow "Login"
    Then I should be on the login page
    When I fill in "Email/Username" with "janee_doe"
    And I fill in "Email/Username" with "jane_doe_password"
    And I press "Login"
    Then I should be on the login page
    And I should see "Invalid login or password"
