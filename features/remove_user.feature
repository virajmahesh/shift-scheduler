Feature: Event creator can remove users from shift
   
    As an event creator, 
    I want to be able to remove users that have joined my shifts 
    so that I have better control over my shifts and who is volunteering.

  Background: User and Event in Database
    Given the following users have registered for accounts:
      | email               | username | password          |
      | creator@uprise.com  | creator  | creator_pass      |
      | volunteer@uprise.com| volunteer| volunteer_pass    |
    And I am on the homepage
    And I log in with username "creator" and password "creator_pass"
    And the following events exist:
      | User    | Event Date | Name          | Candidate | Location |
      | 1       | 03/03/2016 | Go Batman     | Batman    | Gotham   |
    And the following shifts exist:
      | Event    | Role     | Has Limit | Limit | Start Time | End Time | Description |
      | 1        | Tabling  | true      | 4     | 11:00      | 11:30    | Sit all day |
    And the following volunteer commitments exist:
      | User      | Event     | Shift  |
      | volunteer | Go Batman | Tabling|
    And I am on the page for the "Go Batman" event
    
  Scenario: View all the volunteers signed up for a shift
    Given I am on the page for the "Go Batman" event
    And I follow "Tabling"
    Then I should see "View Volunteers"
    When I follow "View Volunteers"
    Then I should see "volunteer"
  
  Scenario: Remove volunteer signed up for a shift
    Given I am on the page for the "Go Batman" event
    And I follow "Tabling"
    When I follow "View Volunteers"
    When I follow "Remove"
    Then I should see "User Removed."
    And I should see "0/4"

  Scenario: Attempt to view all volunteers as non shift creator
    Given I am on the homepage
    And I follow "Logout"
    Given I log in with username "volunteer" and password "volunteer_pass"
    And I am on the page for the "Go Batman" event
    And I follow "Tabling"
    Then I should not see "View Volunteers"