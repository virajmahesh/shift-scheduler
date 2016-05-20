Feature: Users Can Signup for an Account and Use it to Login

  As a user
  I want to signup for an account
  So that I can volunteer for events and all my activity is in one place

  Background:

    Given the following users have registered for accounts:
      | email               | username | password          |
      | jane_doe@uprise.com | jane_doe | jane_doe_password |
    And the following issues exist:
      | Description |
      | Issue 1     |
      | Issue 2     |
      | Issue 3     |
    And the following skills exist:
      | Description |
      | Skill 1     |
      | Skill 2     |
      | Skill 3     |
    And the following skills exist:
      | Description |
      | Organizing  |
      | Outreach    |
      | Fundraising |
    And I am on the homepage

  Scenario: Attempt to signup with valid information
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    Then a user with the username "john_doe" and password "password" should exist in the database
    And I should be on the homepage
    And I should see "Welcome! You have signed up successfully."


  Scenario: Attempt to signup with an existing user's email
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "jane_doe@uprise.com"
    And I fill in "Username" with "jane_doe_new"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    And I should be on the users page
    And I should see "An account with that email address already exists"


  Scenario: Attempt to signup with an existing user's username
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "jane_doe_new@uprise.com"
    And I fill in "Username" with "jane_doe"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    And I should be on the users page
    And I should see "An account with that username already exists"


  Scenario: Attempt to signup without a password
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I press "Sign Up"
    Then I should be on the users page
    And I should see "Password can't be blank"


  Scenario: Attempt to signup without a username
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    Then I should be on the users page
    And I should see "Username can't be blank"


  Scenario: Passwords don't match while signing up
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "passw0rd"
    And I press "Sign Up"
    Then I should be on the users page
    And I should see "Password confirmation doesn't match Password"
    
  Scenario: If form input is partially invalid, valid input should be preserved
    When I follow "Sign Up"
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "passw0rd"
    And I press "Sign Up"
    Then I should see "Password confirmation doesn't match Password"
    And I should see "john_doe@uprise.com" in "Email"
    And I should see "john_doe" in "Username"

  Scenario: No Log in link on the signup page
    When I follow "Sign Up"
    Then I should be on the signup page
    And I should not see "Log in"

  Scenario: Add issues while signing up
    When I follow "Sign Up"
    Then I should be on the signup page
    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I select the following issues: "Issue 1, Issue 2"
    And I press "Sign Up"
    Then a user with the username "john_doe" and password "password" should exist in the database
    And I should be on the homepage
    And user "john_doe" should have "Issue 1" as an issue
    And user "john_doe" should have "Issue 2" as an issue

  Scenario: Edit signup information
    Given I log in with username "jane_doe" and password "jane_doe_password"
    And I follow "jane_doe"
    When I fill in "City" with "Berkeley"
    And I fill in "Current password" with "jane_doe_password"
    And I fill in "State" with "CA"
    And I select the following issues: "Issue 1, Issue 2"
    And I press "Save Changes"
    Then I should be on the homepage
    And I should see "Your account has been updated successfully."