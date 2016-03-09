Feature: Users Can See Which Shifts Have Been Filled

  As a user
  I want to be able to see which shifts have been filled
  so that I can select which shifts I want to volunteer for

  Scenario: view total shifts available
    Given PENDING
    Given I am on the event 1 page
    And event 1 has 4 shifts available
    Then I should see "4 shifts available"

  Scenario: view event with filled shift
    Given PENDING
    Given I am on the event 1 page
    And shift 1 belongs to event 1
    And shift 1 has limit 5
    And there are 5 volunteers for shift 1
    Then I should see "Shift 1 filled"

  Scenario: view event with free shift
    Given PENDING
    Given I am on the event page for event 1
    And shift 1 belongs to event 1
    And shift 1 has limit 5
    And there are 3 volunteers for shift 1
    Then I should see "Shift 1 available"