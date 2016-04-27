ActivityType.create activity: 'User %s has joined shift'
ActivityType.create activity: 'User %s has left shift'
ActivityType.create activity: 'Shift %s for Event %s is full'
ActivityType.create activity: 'You have an event tomorrow: %'
ActivityType.create activity: 'You have a shift tomorrow: %'

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
                            has_limit: 'true', limit: '10',  role: 'Tabling'

bernie_shift = Shift.create event: bernie_event, start_time: '11:20 AM', end_time: '10:00 PM',
                             has_limit: 'false',  role: 'Flyering'
                             
all_skills = Skill.create([{ description: 'Accounting, bookkeeping, compliance' }, 
                         { description: 'Art and design, by hand' },
                         { description: 'Art and design, computer aided' },
                         { description: 'Attending a convention as a delegate' },
                         { description: 'Being a precinct captain' },
                         { description: 'Blogging' },
                         { description: 'Building crowds for events' },
                         { description: 'Canvassing' },
                         { description: 'Collecting signatures' },
                         { description: 'College organizing' },
                         { description: 'Computer programming' },
                         { description: 'Cooking/catering' },
                         { description: 'Data entry' },
                         { description: 'Data management' },
                         { description: 'Driving people or making deliveries' },
                         { description: 'Election day or other GOTV operations' },
                         { description: 'Issue and policy research' },
                         { description: 'Legal assistance, voter protection' },
                         { description: 'Literature drops' },
                         { description: 'Making fundraising calls' },
                         { description: 'Media monitoring' },
                         { description: 'Online research' },
                         { description: 'Opposition research' },
                         { description: 'Opposition tracking' },
                         { description: 'Organizing an event in your home' },
                         { description: 'Organizing an event outside your home' },
                         { description: 'Outreach to issue or identity groups' },
                         { description: 'Outreach to social or professional organizations' },
                         { description: 'Performance: music/dance/other' },
                         { description: 'Phone banking' },
                         { description: 'Press outreach' },
                         { description: 'Producing a major public event' },
                         { description: 'Production: photo/video/audio' },
                         { description: 'Public speaking' },
                         { description: 'Recruiting volunteers' },
                         { description: 'Sign assembly and distribution' },
                         { description: 'Social media' },
                         { description: 'Stuffing envelopes' },
                         { description: 'Tabling public events' },
                         { description: 'Website development' },
                         { description: 'Writing' },
                         { description: 'Youth/teen outreach' }])
                        
all_issues = Issue.create([ { description: 'Advocacy & Human Rights' },
                            { description: 'Animal' },
                            { description: 'Arts & Culture' },
                            { description: 'Board Development' },
                            { description: 'Children & Youth' },
                            { description: 'Community' },
                            { description: 'Computers & Technology' },
                            { description: 'Criminal Justice' },
                            { description: 'Crisis Support' },
                            { description: 'Disaster Relief' },
                            { description: 'Economic Justice' },
                            { description: 'Education & Literacy' },
                            { description: 'Emergency & Safety' },
                            { description: 'Employment' },
                            { description: 'Environment' },
                            { description: 'Faith-Based' },
                            { description: 'Health & Medicine' },
                            { description: 'Homeless & Housing' },
                            { description: 'Human Trafficking' },
                            { description: 'Hunger' },
                            { description: 'Immigrants & Refugees' },
                            { description: 'International' },
                            { description: 'Justice & Legal' },
                            { description: 'LGBT' },
                            { description: 'Media & Broadcasting' },
                            { description: 'People With Disabilities' },
                            { description: 'Politics' },
                            { description: 'Race & Ethnicity' },
                            { description: 'Seniors' },
                            { description: 'Sports & Recreation' },
                            { description: 'Sustainable Food' },
                            { description: 'Veterans & Military Families' },
                            { description: 'Women’s Rights' }])

UserSkill.create user_id:1, skill_id:3
UserSkill.create user_id:1, skill_id:5
ShiftSkill.create shift_id:1, skill_id:8
ShiftSkill.create shift_id:1, skill_id:5
ShiftSkill.create shift_id:1, skill_id:3
ShiftSkill.create shift_id:2, skill_id:3
ShiftSkill.create shift_id:2, skill_id:5
ShiftSkill.create shift_id:2, skill_id:6
EventIssue.create event_id:1, issue_id:33



