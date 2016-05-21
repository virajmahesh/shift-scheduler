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
                                    location: event['Location'], start_time: '10:00 AM', end_time: '11:00 AM'
  end
end

Given (/^the following events will be held tomorrow:$/) do |table|
  table.hashes.each do |event|
    Event.create user: User.find_by(username: event['User']), event_name: event['Name'],
                                    candidate: event['Candidate'], event_date: Date.tomorrow,
                                    location: event['Location'], start_time: '10:00 AM', end_time: '11:00 AM'
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

Given(/^the following user skills exist:$/) do |table|
  table.hashes.each do |user_skill|
    user = User.find_by_username user_skill['User']
    skill = Skill.find_by_description user_skill['Skill']

    UserSkill.create user: user, skill: skill
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

Given(/^the following user_activities exist:$/) do |table|
  table.hashes.each do |user_activity|
    UserActivity.create owner_id: user_activity['Owner'], user_id: user_activity['User'], type: user_activity['Type'],
                  shift_id: user_activity['Shift'], event_id: user_activity['Event']
  end
end

Given (/^the following issues exist:$/) do |table|
  table.hashes.each do |issue|
    Issue.create description: issue['Description']
  end
end

Given (/^the following event issues exist:$/) do |table|
  table.hashes.each do |event_issue|
    event = Event.find_by_event_name event_issue['Event']
    issue = Issue.find_by_description event_issue['Issue']
    EventIssue.create event: event, issue: issue
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
  event = Event.find_by_event_name event_name
  event.nil?.should == true
end

Then (/^a shift with role "(.*)" should exist$/) do |shift_role|
  shift = Shift.find_by role: shift_role
  shift.nil?.should == false
end

Then (/^a shift with role "(.*)" should not exist$/) do |shift_role|
  shift = Shift.find_by_role shift_role
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
  issues_to_add = Issue.where description: issues.split(', ')
  current_issues = find('#issue_ids', visible: false).value.split(',').map { |i| i.to_i }

  current_issues << issues_to_add.pluck(:id)
  page.find('#issue_ids', visible: false).set current_issues.join(',')
end

When (/^I select the following skills: "(.*)"$/) do |skills|
  skills_to_add = Skill.where description: skills.split(', ')
  current_skills = find('#skill_ids', visible: false).value.split(',').map { |i| i.to_i }

  current_skills << skills_to_add.pluck(:id)
  page.find('#skill_ids', visible: false).set current_skills.join(',')
end

When (/^I remove the following skills: "(.*)"$/) do |skills|
  skills_to_remove = Skill.where description: skills.split(', ')
  current_skills = find('#skill_ids', visible: false).value.split(',').map { |i| i.to_i }

  skills_to_remove.each do |skill|
    current_skills.delete skill.id
  end

  page.find('#skill_ids', visible: false).set current_skills.join(',')
end

When (/^I remove the following issues: "(.*)"$/) do |issues|
  issues_to_remove = Issue.where description: issues.split(', ')
  current_issues = find('#issue_ids', visible: false).value.split(',').map { |i| i.to_i }

  issues_to_remove.each do |issue|
    current_issues.delete issue.id
  end

  page.find('#issue_ids', visible: false).set current_issues.join(',')
end

Then (/^the "(.*)" event should have "(.*)" as an issue$/) do |event_name, issue_desc|
  event = Event.find_by_event_name event_name
  issue = Issue.find_by_description issue_desc

  event.has_issue?(issue).should == true
end

Then (/^the "(.*)" event should not have "(.*)" as an issue$/) do |event_name, issue_desc|
  event = Event.find_by_event_name event_name
  issue = Issue.find_by_description issue_desc

  event.has_issue?(issue).should == false
end

Then (/^user "(.*)" should have "(.*)" as an issue$/) do |username, issue_desc|
  user = User.find_by_username username
  issue = Issue.find_by_description issue_desc

  user.has_issue?(issue).should == true
end

Then (/^the "(.*)" shift of the "(.*)" event should have "(.*)" as a skill/) do |role, event_name, skill_desc|
  event = Event.find_by_event_name event_name
  shift = Shift.find_by event: event, role: role

  skill = Skill.find_by_description skill_desc
  shift.has_skill?(skill).should == true
end

Then (/^the "(.*)" shift of the "(.*)" event should not have "(.*)" as a skill/) do |role, event_name, skill_desc|
  event = Event.find_by_event_name event_name
  shift = Shift.find_by event: event, role: role

  skill = Skill.find_by_description skill_desc
  shift.has_skill?(skill).should == false
end

Then (/^the page should contain a multiline textbox$/) do
  page.body.include?('textarea').should == true
end

When (/^I wait (.*) second(?:|s)$/) do |seconds|
  sleep seconds.to_d
end

Given (/^the "(.*)" event is today$/) do |event_name|
  event = Event.find_by_event_name event_name
  event.event_date = Time.now.to_date

  event.save
end

Then (/^"(.*)" should have (.*) unread notification(?:|s)$/) do |username, count|
  count = count.to_i
  user = User.find_by_username username

  UserActivity.where(owner_id: user, read: false).count.should == count
end

Given (/^PENDING$/) do
  pending
end
