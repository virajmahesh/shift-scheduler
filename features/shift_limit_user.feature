Feature: Event Creators Can limit the number of users that can sign up for a shift

        As an event creator
        I want to be able to limit the number of people that can sign up for a shift 
        so that I don’t have too many volunteers for the same shift

Scenario: attempt to sign up for shift that has space
        Given shift 1 has a limit
        And the limit of shift 1 is 5
        And shift 1 has 4 users
        Given the user John Doe exists
        When John Doe signs up for shift 1
        shift 1 should have one more user
        John Doe should have one more commitment
        And John Doe should be on the event page
        And John Doe should see 'You have been signed up for the shift' on the event page

Scenario: attempt to sign up for shift that is at capacity
        Given shift 1 has a limit
        And the limit of shift 1 is 5
        And shift 1 has 5 users
        Given the user John Doe exists
        When John Doe sign up for shift 1
        Then John Doe's volunteer commitments should not change
        And John Doe should be on the event page
        And John Doe should see 'Shift already full' on the event page



