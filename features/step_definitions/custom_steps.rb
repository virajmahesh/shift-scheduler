include BCrypt

Given(/^the following users have registered for accounts:$/) do |table|
  table.hashes.each do |user|
    email = user[:email]
    username = user[:username]
    password = user[:password]

    User.create email: email, username: username,
                password: password, password_confirmation: password
  end
end

Given(/^the following events exist:$/) do |table|
  table.hashes.each do |event|
    Event.create user: User.find(event['User']), event_name: event['Name'],
                 candidate: event['Candidate'], event_date: event['Date']
  end
end

Given(/^the following shifts exist:$/) do |table|
  table.hashes.each do |shift|
    Shift.create event: Event.find(shift['Event']), role: shift['Role'],
                 has_limit: shift['Has Limit'], limit: shift['Limit'],
                 start_time: shift['Start Time'], end_time: shift['End Time']
  end
end

Given (/^"(.*)" has signed up for the "(.*)" shift for the "(.*)" event$/) do |username, shift_role, event_name|
  user = User.find_by username: username
  event = Event.find_by event_name: event_name
  shift = Shift.find_by role: shift_role, event: event

  VolunteerCommitment.create user: user, shift: shift
end

Then (/^the "(.*)" shift for the "(.*)" event should have (\d+) volunteers$/) do |shift_role, event_name, volunteers|
  event = Event.find_by event_name: event_name
  shift = Shift.find_by role: shift_role, event: event
  shift.users.length.should == volunteers.to_i
end

Given(/^I log in with username "(.*)" and password "(.*)"$/) do |username, password|
  visit login_path
  fill_in 'login', :with => username
  fill_in 'password', :with => password
  click_button 'Login'
end

Then(/^shift (\d+) should have (\d+) users$/) do |shift_id, num_users|
  num_volunteers = VolunteerCommitment.where(shift_id: shift_id).size
  num_volunteers.should == num_users.to_i
end

Then(/^"(.*)" should have (\d+) volunteer commitment(?:|s)$/) do |username, expected_commitments|
  user = User.find_by username: username
  user.volunteer_commitments.length.should == expected_commitments.to_i
end


Then (/^an event named "(.*)" should exist$/) do |event_name|
  event = Event.find_by event_name: event_name
  event.nil?.should == false
end

Then (/^an event named "(.*)" should not exist$/) do |event_name|
  event = Event.find_by event_name: event_name
  event.nil?.should == true
end

Then (/^a shift with role "(.*)" should exist$/) do |shift_role|
  shift = Shift.find_by role: shift_role
  shift.nil?.should == false
end

Then (/^a shift with role "(.*)" should not exist$/) do |shift_role|
  shift = Shift.find_by role: shift_role
  shift.nil?.should == true
end

Then(/^a user with the username "(.*)" and password "(.*)" should exist in the database$/) do |username, password|
  user = User.find_by username: username
  user.authenticate(password).nil?.should == false
end

Then(/^the page should contain "([^"]*)"$/) do |content|
  pending
end


Given (/^PENDING$/) do
  pending
end