Feature: Users Can Signup for an Account and Use it to Login
  
  As a user
  I want to signup for an account
  So that I can volunteer for events and all my activity is in one place


Background:
  Given that I am on the uprise homepage


Scenario: attempt to signup with valid information
  When I click the signup button
  Then I should be on the signup page
  
  When I enter 'john_doe@uprise.com' into the email field
  And I enter 'john_doe' into the username field
  And I enter 'password' into the password field
  And I enter 'password' into the confirm password field
  And I click signup
  
  Then a user with the username 'john_doe' and password 'password' should exist in the database
  And I should be on the uprise homepage
  And I should see 'john_doe' on the page
  

Scenario: attempt to signup with incomplete information
  When I click the signup button
  Then I should be on the signup page

  When I enter 'john_doe@uprise.com' into the email field
  And I enter 'john_doe' into the username field
  And I click signup
  
  Then I should be on the signup page
  And I should see 'Error! Please fill in all the required information' on the page
  
  
Scenario: passwords don't match while signing up
  When I click the signup button
  Then I should be on the signup page
  
  When I enter 'john_doe@uprise.com' into the email field
  And I enter 'john_doe' into the username field
  And I enter 'password' into the password field
  And I enter 'pasword' into the confirm password field
  And I click signup
  
  Then I should be on the signup page
  And I should see 'Error! Passwords don't match' on the page
  And the password field should be empty
  And the confirm password field should be empty
  But the username field should contain 'john_doe'
  And the email field should contain 'john_doe@uprise.com'
  