Feature: User can Create, edit and delete events

  As a User
  I want to be able to create/edit/delete an event
  So that I can get potential volunteers interested in my cause/campaign.

  Background:
    Given that I am on the uprise homepage
    And that I am signed in

  Scenario: attempt to create an event
    When I click the create button
    Then I should be on the create event page

    When I enter "Batman for President" in the events name field
    And I enter "Gotham" in the location field
    And I enter "03/03/2016" in the event date field
    And I enter "Batman" in the candidate field
    And I enter "a fund raiser for Batman" in the description field
    And I click 'Create Event'

    Then I should be on the events created page
    And I should see the new event on the page

  Scenario: attempt to create event with incomplete information
    When I click the create button
    Then I should be on the create event page

    When I enter "Batman for president" in the events name field
    And I enter "Gotham" in the location field
    And I enter "03/03/2016" in the event date field
    And I click 'Create Event'

    Then I should be on the signup page
    And I should see 'Error! Please fill in all the required information' on the page

  Scenario: attempt to delete an event
    When I click on 'my events'
    Then I should be on my events created page

    When I click on the "Batman for president" event
    And I click the delete button


    Then I should be on the created events page
    And I should see a message saying "event deleted"
    And I should not see "Batman for president" event on the page

  Scenario: attempt to edit an event
    When I click on 'my events'
    Then I should be on my events created page

    When I click on the "Batman for president" event
    And I click the edit event button

    Then I should be on the edit event page

    When I enter "03/04/2016" in the event date field
    And I click save changes

    Then I should be on the "Batman for president" event page
    And I should see "03/04/2016" as the date of the event




