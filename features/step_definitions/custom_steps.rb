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

Given /^PENDING/ do
  pending
end

Given (/^shift (.*) has limit (.*)$/) do |shift_id, limit|
  Shift.create({:id => shift_id,:limit => limit,:has_limit => true, :role => 'Tabler', :created_at => Time.now, :updated_at => Time.now})
end


And (/^shift (.*) has (.*) users$/) do |shift_id, limit|
  
  
end
