require 'spec_helper'

describe User do

  before :each do
    @user = User.create email: 'email@email.com', username: 'username',
                        password: 'password', password_confirmation: 'password'
  end

  describe 'password hashing' do
    it 'should hash user passwords before storing them' do
      @user.encrypted_password.should_not ==  'password'
    end
  end

  describe 'type' do
    it 'should return the correct type' do
      @user.type.should == 'User'
    end
  end

  describe 'has_issues?' do
    before :each do
      @issue = FactoryGirl.create :issue
    end

    it 'should return true when the user is linked with the issue' do
      @user.issues << @issue
      @user.save

      @user.has_issue?(@issue).should == true
    end

    it 'should return false when the user is not linked with the issue' do
      @user.has_issue?(@issue).should == false
    end
  end

end
