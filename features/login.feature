Feature: Users Can Login With Their Credentials
  
  As a user
  I want to login with my credentials (email/username + password)
  So that I can prevent unauthorized access to my account
  
Background: users that have registered
  
  Given the following users have registered for accounts:
  | email               | username | password          |
  | john_doe@uprise.com | john_doe | john_doe_password |
  | jane_doe@uprise.com | jane_doe | jane_doe_password |
  
  And I am on the uprise homepage
 

Scenario: attempt to login with email and password
  When I click the login button
  Then I should be on the login page
  
  When I enter 'john_doe@uprise.com' into the username field
  And I enter 'john_doe_password' into the password field
  And I click login
  
  Then I should be on the uprise homepage
  And I should see 'john_doe' on the page


Scenario: attempt to login with username and password
  When I click the login button
  Then I should be on the login page
  
  When I enter 'jane_doe' into the username field
  And I enter 'jane_doe_password' into the password field
  And I click login
  
  Then I should be on the uprise homepage
  And I should see 'jane_doe' on the page
  

Scenario: attempt to login with incorrect username and password
  When I click the login button
  Then I should be on the login page
  
  When I enter 'janee_doe' into the username field  # Typo in username
  And I enter 'jane_doe_password' into the password field
  And I click login
  
  Then I should be on the login page
  And I should see 'Error: Invalid username/password!' on the page
