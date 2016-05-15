user = User.create email: 'test_user@gmail.com', username: 'test_user',
                   password: 'test_password', password_confirmation: 'test_password',
                   city: 'Berkeley', state: 'CA', zip_code: '94704', phone_number: '510-646-5945'

hillary_event = Event.create user: user, event_name: 'Caucus for Hillary',
                             location: 'Berkeley, CA', event_date: '10/04/2018', start_time: '10:00 AM', end_time: '11:00 AM',
                             candidate: 'Hillary Clinton', description: 'Come out and support Hillary by caucusing for her'

bernie_event = Event.create user: user, event_name: 'Bake sale for Bernie',
                            location: 'Berkeley, CA', event_date: '09/07/2018', start_time: '9:00 AM', end_time: '11:00 AM',
                            candidate: 'Bernie Sanders', description: 'Come out and support Bernie at this bakesale'

hillary_shift = Shift.create event: hillary_event, start_time: '10:00 AM', end_time: '10:40 AM',
                            has_limit: 'true', limit: '10',  role: 'Canvassing'

bernie_shift = Shift.create event: bernie_event, start_time: '11:20 AM', end_time: '10:00 PM',
                             has_limit: 'false',  role: 'Phone Banking'

File.open('db/seed data/skills').each do |skill|
  Skill.create description: skill
end

File.open('db/seed data/issues').each do |issue|
  Issue.create description: issue
end

UserSkill.create user_id:1, skill_id:3
UserSkill.create user_id:1, skill_id:5
ShiftSkill.create shift_id:1, skill_id:8
ShiftSkill.create shift_id:1, skill_id:5
ShiftSkill.create shift_id:1, skill_id:3
ShiftSkill.create shift_id:2, skill_id:3
ShiftSkill.create shift_id:2, skill_id:5
ShiftSkill.create shift_id:2, skill_id:6
EventIssue.create event_id:1, issue_id:33



