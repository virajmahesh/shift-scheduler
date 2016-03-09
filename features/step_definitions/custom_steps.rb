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

Given(/^the following events exists:$/) do |table|
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


Then (/^a user with the username "(.*)" and password "(.*)" should exist in the database$/) do |username, password|
  user = User.find_by username: username

  user.nil?.should == false
  user.username.should == username
  user.authenticate password .should_not == false
end

Given (/^a user has signed up with the email "(.*)"$/) do |email|
  User.create email: email, username: 'username',
              password: 'password', password_confirmation: 'password'
end

When /^I try to join shift (\d+) through the URL$/ do |id|
  post shift_path(id)
end

Given (/I am signed in as "(.*)"$/) do |username|
  user = User.create email: username + '@email.com', username: username,
                     password: 'password', password_confirmation: 'password'
  session[:user_id] = user.id
end

Given(/^shift (\d+) has a limit (\d+)$/) do |shift_id, limit|
  Shift.create(:id => shift_id, :limit => limit, :has_limit => true, :role => 'Tabler')
end

Given(/^user (.*) exists with password (.*)$/) do |username, password|
  User.create id:1, email: "sample@email.com", username: username,
              password: password, password_confirmation: password
end

Given(/^shift (\d+) has (\d+) users$/) do |shift_id, num_users|
  (1..num_users.to_i).each do |index|
    VolunteerCommitment.create(:user_id => 2, :shift_id => shift_id)
  end
end

Given(/^user (.*) is logged in with password (.*)$/) do |username, password|
  visit login_path
  fill_in "login", :with => username
  fill_in "password", :with => password
  click_button "Login"
end

When(/^(.*) signs up for shift (\d+)$/) do |username, shift_id|
  visit shift_path(shift_id)
  click_link("Join")
end

Then(/^shift (\d+) should have (\d+) users$/) do |shift_id, num_users|
  num_volunteers = VolunteerCommitment.where(shift_id: shift_id).size
  expect(num_volunteers).to eq(num_users.to_i)
end

Then(/^(.*) should have (\d+) commitment(?:|s)$/) do |username, expected_commitments|
  user = User.find_by :username => username
  user.volunteer_commitments.length.should == expected_commitments.to_i
end

Given(/^event (\d+) has (\d+) shifts with (\d+) spaces available$/) do |event_id, num_shifts, limit|
  (1..num_shifts.to_i).each do
    Shift.create(:start_time => Time.now, :end_time => Time.now, :event_id => event_id, :limit => limit.to_i, :has_limit => true, :role => 'Tabler')
  end
end

Given(/^* visit the event (\d+) page$/) do |event_id|
  visit event_path(event_id)
end

Given(/^* visit the shift "(.*)" page$/) do |shift_role|
  visit shift_path(shift_role)
end

Then (/^an event named "(.*)" should exist$/) do |event_name|
  event = Event.find_by event_name: event_name
  event.nil?.should == false
end

Then (/^an event named "(.*)" should not exist$/) do |event_name|
  event = Event.find_by event_name: event_name
  event.nil?.should == true
end

Then (/^a shift named "(.*)" should exist$/) do |shift_role|
  shift = Shift.find_by role: shift_role
  shift.nil?.should == false
end

Then (/^a shift named "(.*)" should not exist$/) do |shift_role|
  shift = Shift.find_by role: shift_role
  shift.nil?.should == true
end

Then (/^the "(.*)" field for event "(.*)" should be "(.+)"$/) do |field, event_name, value|
  event = Event.find_by event_name: event_name
  date = event.event_date
  date.to_s.should == value
end


Then (/^the "(.*)" field for shift "(.*)" should be "(.+)"$/) do |field, shift_role, value|
  event = Event.find_by event_name: event_name
  date= event.event_date
  date.to_s.should == value
end