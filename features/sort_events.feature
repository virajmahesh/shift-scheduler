Feature: User can sort events based on Date, Most Members, Best Match
  
  As a user,
  I want to be able to sort the list of events
  so that I can find more relevant events
  
    Background:
    Given the following users have registered for accounts:
      | email               | username | password          |
      | john_doe@uprise.com | john_doe | john_doe_password |
    And I am on the homepage
    And the following events exist:
      | User     | Name       | Location  | Candidate | Event Date | Created At
      | john     | Go Batman  | Gotham    | Batman    | 03/04/2018 | 03/04/2016
      | john     | Go Joker   | Gotham    | Joker     | 03/05/2017 | 03/05/2016
      | john     | Go Robin   | Gotham    | Robin     | 03/03/2017 | 03/03/2016
      
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time | 
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    |
      | Go Batman | Chef     | true      | 1     | 12:00      | 12:30    |
      | Go Robin  | Tabling  | true      | 1     | 12:00      | 12:30    |
      | Go Joker  | Writing  | true      | 1     | 12:00      | 12:30    |
    And the following volunteer commitments exist
      | User       | Event     | Shift    |
      | user1      | Go Batman | Tabling  |
      | user2      | Go Robin  | Flyering |
      | user3      | Go Robin  | Chef     |
      | user4      | Go Joker  | Setup    |
      | user5      | Go Joker  | Driver   |
      | user6      | Go Joker  | Setup    |

  Scenario: Attempt to sort events by newest
    Given PENDING
    Given I choose to sort events by "Newest"
    Then I should be on the homepage
    And I should see "Go Robin" event before "Go Batman" event
    And I should see "Go Batman" event before "Go Joker" event 

  Scenario: Attempt to sort events by most members
    Given PENDING
    Given I choose to sort events by "Most Members"
    Then I should be on the homepage
    And I should see "Go Joker" event before "Go Robin" event
    And I should see "Go Robin" event before "Go Batman" event

  Scenario: Attempt to sort events by best match
    Given PENDING
    Given that I has the following skills: "Tabling public events", "Cooking/catering"
    And I choose to sort events by "Best Match "
    Then I should be on the homepage
    And I should see "Go Batman" event before "Go Robin" event
    And I should see "Go Robin" event before "Go Joker" event