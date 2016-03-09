Feature: Users Can See Which Shifts Have Been Filled

  As a user
  I want to be able to see which shifts have been filled
  so that I can select which shifts I want to volunteer for

  Scenario: view total shifts available
    Given event 1 exists 
    And event 1 has 1 shifts with 5 spaces available
    When I visit the event 1 page
    Then I should see "1 shifts available"

  Scenario: view event with filled shift
    Given event 1 exists 
    And event 1 has 1 shifts with 0 spaces available
    When I visit the event 1 page
    Then I should see "0/0 volunteers signed up"

  Scenario: view event with free shift
    Given event 1 exists 
    And event 1 has 1 shifts with 5 spaces available
    When I visit the event 1 page
    Then I should see "0/5 volunteers signed up"