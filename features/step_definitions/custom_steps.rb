Given (/^the following users have registered for accounts:$/) do |table|
  table.hashes.each do |user|
    email = user[:email]
    username = user[:username]
    password = user[:password]

    User.create email: email, username: username,
                password: password, password_confirmation: password
  end
end

Given (/^the following events exist:$/) do |table|
  table.hashes.each do |event|
    Event.create user: User.find_by(username: event['User']), event_name: event['Name'],
                                    candidate: event['Candidate'], event_date: event['Event Date'],
                                    location: event['Location']
  end
end

Given (/^the following shifts exist:$/) do |table|
  table.hashes.each do |shift|
    Shift.create event: Event.find_by(event_name: shift['Event']), role: shift['Role'],
                 has_limit: shift['Has Limit'], limit: shift['Limit'],
                 start_time: shift['Start Time'], end_time: shift['End Time'],
                 description: shift['Description']
  end
end

Given (/^the following skills exist:$/) do |table|
  table.hashes.each do |skill|
    Skill.create description: skill['Description']
  end
end

Given(/^the following shift skills exist:$/) do |table|
  table.hashes.each do |shift_skill|
    event = Event.find_by event_name: shift_skill['Event']
    shift = Shift.find_by event: event, role: shift_skill['Shift']
    skill = Skill.find_by description: shift_skill['Skill']
    ShiftSkill.create shift: shift, skill: skill
  end
end

Given(/^the following volunteer commitments exist:$/) do |table|
  table.hashes.each do |commitment|
    user = User.find_by username: commitment['User']
    event = Event.find_by event_name: commitment['Event']
    shift = Shift.find_by event: event, role: commitment['Shift']

    VolunteerCommitment.create user: user, shift: shift
  end
end

Given (/^the following activity_types exist:$/) do |table|
  table.hashes.each do |activity_type|
    ActivityType.create({activity: activity_type['Activity'] + " "})
  end
end

Given (/^the following user_activities exist:$/) do |table|
  table.hashes.each do |user_activity|
    UserActivity.create user_id: user_activity['User'], activity_type_id: user_activity['Activity'],
                  shift_id: user_activity['Shift']
  end
end

Given (/^the following issues exist:$/) do |table|
  table.hashes.each do |issue|
    Issue.create description: issue['Description']
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
  visit new_user_session_path
  fill_in 'Email/Username', :with => username
  fill_in 'Password', :with => password
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
  user.nil?.should == false
  user.valid_password?(password).should == true
end

When (/^I select "(.*)" as the (.*) "(.*) Time"$/) do |time, model, field|
  model.downcase!
  field.downcase!
  time = Time.parse(time)

  select time.strftime('%I %p'), from: "#{model}[#{field}_time(4i)]"
  select time.strftime('%M'), from: "#{model}[#{field}_time(5i)]"
end

Then (/^I should see "(.*)" in "(.*)"$/) do |value, field|
  find_field(field).value.should eq value
end

When (/^I select the following issues: "(.*)"$/) do |issues|
  issues = issues.split(', ')
  issues.each do |issue|
    input = page.find('#issues').find('input')

    # Click the input and type in the issue
    input.click
    input.set(issue)
    page.find('span.highlight', text: issue, visible: false).trigger('click')
  end
end

When (/^I select the following skills: "(.*)"$/) do |skills|
  pending
end

Then (/^the "(.*)" event should have "(.*)" as an issue$/) do |event_name, issue_desc|
  event = Event.find_by_event_name event_name
  issue = Issue.find_by_description issue_desc

  event.has_issue?(issue).should == true
end

Then (/^user "(.*)" should have "(.*)" as an issue$/) do |username, issue_desc|
  user = User.find_by_username username
  issue = Issue.find_by_description issue_desc

  user.has_issue?(issue).should == true
end

Given (/^PENDING$/) do
  pending
end
