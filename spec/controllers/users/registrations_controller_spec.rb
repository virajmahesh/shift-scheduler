require 'spec_helper'

describe Users::RegistrationsController do

  before :each do
    @user = FactoryGirl.create :user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'signup' do
    it 'should allow a user to signup with valid information' do
      post :create, user: {email: 'email@email.com', username: 'username_new',
                          password: 'password', password_confirmation: 'password'}

      user = User.find_by email: 'email@email.com'

      user.nil?.should == false
      user.valid_password?('password').should == true
    end
  end
end