Feature: Users Can See All Future Events on the Home Page

  As a user
  I want to be able to see a list of all future events
  so that I can sign up to volunteer for one or more events

  Background: shifts in database

    Given event 1 exists
    And the following shifts exist

      | event_id | start_time     | end_time       | role     | has_limit | limit | volunteers |
      | 1        | 11:30 4-1-2016 | 12:30 2016-4-1 | tabling  | true      | 3     | 2          |
      | 2        | 10:00 4-1-2016 | 15:30 2016-4-1 | flyering | true      | 3     | 2          |


  Scenario: view all future events
    Given that I am on the homepage
    And that I am signed in
    Then I should see "Events: event 1, event 2"