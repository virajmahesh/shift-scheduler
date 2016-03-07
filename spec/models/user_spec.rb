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
      @user.password_digest.should_not ==  'password'
    end
  end

  describe 'user authentication' do

    it 'should succeed when the user inputs the correct password' do
      @user = @user.authenticate 'password'
      @user.should == @user
    end

    it 'should fail when the user inputs the wrong password' do
      @user = @user.authenticate 'passw0rd'
      @user.should == false
    end

  end
end