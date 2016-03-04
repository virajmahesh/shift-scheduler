Feature: Users Can See Different Shifts that Are a Part of an Event

As a user
I want to see all the different shifts associated with an event 
So that I can select which shifts I want to volunteer for



Scenario: view all shifts
	Given that I am on the event page for event 1
	And that I am signed in 
	Then I should see see all shifts associated with an event ordered by start time