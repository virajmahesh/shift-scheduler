user = User.create email: 'test_user@gmail.com', username: 'test_user',
                   password: 'test_password', password_confirmation: 'test_password',
                   city: 'Berkeley', state: 'CA', zip_code: '94704', phone_number: '510-646-5945'

hillary_event = Event.create user: user, event_name: 'Caucus for Hillary',
                             location: 'Berkeley, CA', event_date: '10/04/2018',
                             candidate: 'Hillary Clinton', description: 'Come out and support Hillary by caucusing for her'

bernie_event = Event.create user: user, event_name: 'Bake sale for Bernie',
                            location: 'Berkeley, CA', event_date: '09/07/2018',
                            candidate: 'Bernie Sanders', description: 'Come out and support Bernie at this bakesale'

hillary_shift = Shift.create event: hillary_event, start_time: '10:00 AM', end_time: '10:40 AM',
                             role: 'Setup', has_limit: 'true', limit: '10'

bernie_shift = Shift.create event: bernie_event, start_time: '11:20 AM', end_time: '10:00 PM',
                             role: 'Baking', has_limit: 'false'