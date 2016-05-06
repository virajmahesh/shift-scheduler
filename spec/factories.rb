FactoryGirl.define do
  sequence :username do |n|
    "test#{n}user"
  end

  sequence :email do |n|
    "test#{n}@example.com"
  end

  sequence :issue do |n|
    "test issue #{n}"
  end

  sequence :skill do |n|
    "test skill #{n}"
  end

  factory :user do
    email {generate :email}
    username {generate :username}
    password 'password'
    password_confirmation 'password'
    city 'Berkeley'
  end

  factory :event do
    event_name 'Test Event'
    event_date '10/04/2018'
    start_time '10:00 AM'
    end_time '11:00 AM'
    location 'Berkeley'
    candidate 'Test Candidate'
  end

  factory :shift do
    start_time '10:00 PM'
    end_time '10:10 PM'
    role 'Tabling'
    has_limit 'false'
  end

  factory :issue do
    description {generate :issue}
  end

  factory :skill do
    description {generate :skill}
  end

end
