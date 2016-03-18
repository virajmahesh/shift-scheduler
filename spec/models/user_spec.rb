require 'spec_helper'
require 'bcrypt'

include BCrypt

describe User do

  before :each do
    @user = User.create email: 'email@email.com', username: 'username',
                        password: 'password', password_confirmation: 'password'
  end

  describe 'user user' do
    it 'should hash user passwords before storing them' do
      @user.encrypted_password.should_not ==  'password'
    end
  end

  describe 'Signed Up For Shift' do
    it 'should return true when the user is signed up for the shift' do
      @shift = Shift.create
    end
  end

  describe 'Email Notifications' do
    it 'should return email when mailboxer calls email' do
      @user.mailboxer_email(@user) == 'email@email.com'
    end
  end

end
