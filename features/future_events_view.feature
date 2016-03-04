Feature: Users Can See All Future Events on the Home Page

As a user
I want to be able to see a list of all future events
so that I can sign up to volunteer for one or more events


Scenario: view all future events
	Given that I am on the homepage
	And that I am signed in
	Then I should see all events 