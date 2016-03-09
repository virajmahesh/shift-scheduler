Feature: Event Creators Can limit the number of users that can sign up for a shift

  As an event creator
  I want to be able to limit the number of people that can sign up for a shift
  so that I don’t have too many volunteers for the same shift

  Scenario: attempt to sign up for shift that has space
    Given shift 1 has a limit 5
    And shift 1 has 4 users
    Given user John Doe exists with password hellboy
    And user John Doe is logged in with password hellboy
    When John Doe signs up for shift 1
    Then shift 1 should have 5 users
    And John Doe should have 1 commitments
    And John Doe should see "You have been signed up"

  Scenario: attempt to sign up for shift that is at capacity
    Given shift 1 has a limit 5
    And shift 1 has 5 users
    Given user John Doe exists with password hellboy
    And user John Doe is logged in with password hellboy
    When John Doe signs up for shift 1
    Then shift 1 should have 5 users
    And John Doe should have 0 commitments
    And John Doe should see "Shift already full"
