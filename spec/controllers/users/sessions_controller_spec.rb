require 'spec_helper'

describe Users::SessionsController do

  before :each do
    @user = FactoryGirl.create :user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'login action' do
    it 'should allow a user to login with the email and the correct password' do
      @user.email = 'user@email.com'
      @user.password = 'password'
      @user.save

      post :create, user: {login: 'user@email.com', password: 'password'}

      current_user.should == @user
    end

    it 'should not allow a user to login with the email and the wrong password' do
      @user.email = 'user@email.com'
      @user.password = 'password'
      @user.save

      post :create, user: {:login => 'user@email.com', :password => 'passw0rd'}

      current_user.should == nil
    end

    it 'should allow a user to login with the username and the correct password' do
      @user.username = 'username'
      @user.password = 'password'
      @user.save

      post :create, user: {:login => 'username', :password => 'password'}

      current_user.should == @user
    end

    it 'should not allow a user to login with the username and the incorrect password' do
      @user.username = 'username'
      @user.password = 'password'
      @user.save

      post :create, user: {:login => 'username', :password => 'passw0rd'}

      current_user.should == nil
    end
  end

  describe 'logout action' do
    it 'should logout a user that is logged in' do
      sign_in @user
      current_user.should == @user

      delete :destroy

      current_user.should == nil
    end
  end
end