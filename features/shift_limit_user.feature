Feature: Event Creators Can limit the number of users that can sign up for a shift

  As an event creator
  I want to be able to limit the number of people that can sign up for a shift
  so that I don’t have too many volunteers for the same shift

  Scenario: attempt to sign up for shift that has space
    Given shift 1 has a limit 5
    And shift 1 has 4 users
    Given the user John Doe exists
    When John Doe signs up for shift 1
    Then shift 1 should have one more user
    And John Doe should have one more commitment
    And John Doe should be on the shift 1 page
    And John Doe should see 'You have been signed up for the shift'

  Scenario: attempt to sign up for shift that is at capacity
    Given shift 1 has a limit 5
    And shift 1 has 5 users
    Given the user John Doe exists
    When John Doe sign up for shift 1
    Then John Doe's volunteer commitments should not change
    And John Doe should be on the shift 1 page
    And John Doe should see 'Shift already full'