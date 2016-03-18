FactoryGirl.define do
  factory :user do
    email 'user@email.com'
    username 'username'
    password 'password'
    password_confirmation 'password'
    city 'Berkeley'
  end

  factory :event do
    event_name 'Test Event'
    event_date '10/04/2018'
    location 'Berkeley'
    candidate 'Batman'
  end
end
