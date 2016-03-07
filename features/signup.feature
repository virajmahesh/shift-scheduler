Feature: Users Can Signup for an Account and Use it to Login

  As a user
  I want to signup for an account
  So that I can volunteer for events and all my activity is in one place


  Background:
    Given I am on the homepage


  Scenario: attempt to signup with valid information
    When I follow "Sign Up"
    Then I should be on the signup page

    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "password"
    And I press "Sign Up"

    Then a user with the username "john_doe" and password "password" should exist in the database
    And I should be on the homepage
    And I should see "john_doe"


  Scenario: attempt to signup with an existing user's email
    Given a user has signed up with the email "john_doe@uprise.com"

    When I follow "Sign Up"
    Then I should be on the signup page

    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "password"
    And I press "Sign Up"

    And I should be on the signup page
    And I should see "An account with that email address already exists"


  Scenario: attempt to signup without a password
    When I follow "Sign Up"
    Then I should be on the signup page

    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I press "Sign Up"

    Then I should be on the signup page
    And I should see "Password can't be blank"


  Scenario: attempt to signup without a username
    When I follow "Sign Up"
    Then I should be on the signup page

    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "password"
    And I press "Sign Up"

    Then I should be on the signup page
    And I should see "Username can't be blank"


  Scenario: passwords don't match while signing up
    When I follow "Sign Up"
    Then I should be on the signup page

    When I fill in "Email" with "john_doe@uprise.com"
    And I fill in "Username" with "john_doe"
    And I fill in "Password" with "password"
    And I fill in "Confirm Password" with "passw0rd"
    And I press "Sign Up"

    Then I should be on the signup page
    And I should see "Password confirmation doesn't match Password"
  