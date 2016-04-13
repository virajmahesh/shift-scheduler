ActivityType.create activity: 'User %s has joined shift'
ActivityType.create activity: 'User %s has left shift'
ActivityType.create activity: 'Shift %s for Event %s is full'

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
                            has_limit: 'true', limit: '10'

bernie_shift = Shift.create event: bernie_event, start_time: '11:20 AM', end_time: '10:00 PM',
                             has_limit: 'false'
                             
all_roles = Role.create([{ description: 'Accounting, bookkeeping, compliance' }, 
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

test_user_role1 = UserRole.create user_id:1, role_id:3
test_user_role2 = UserRole.create user_id:1, role_id:5
hillary_shift_role1 = ShiftRole.create shift_id:1, role_id:8
hillary_shift_role2 = ShiftRole.create shift_id:1, role_id:5
hillary_shift_role3 = ShiftRole.create shift_id:1, role_id:3
bernie_shift_role1 = ShiftRole.create shift_id:2, role_id:3
bernie_shift_role2 = ShiftRole.create shift_id:2, role_id:5
bernie_shift_role3 = ShiftRole.create shift_id:2, role_id:6


