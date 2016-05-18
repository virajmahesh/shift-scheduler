require 'spec_helper'

describe Users::RegistrationsController do

  before :each do
    @user = FactoryGirl.create :user
    @event = FactoryGirl.create :event, user: @user
    @request.env['devise.mapping'] = Devise.mappings[:user]
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

    it 'should notify users about existing shifts that match their skills' do
      @skill = FactoryGirl.create :skill
      @shift = FactoryGirl.create :shift, event: @event
      ShiftSkill.create shift: @shift, skill: @skill

      # Sign up as a new user
      @new_user = {email: 'email@email.com', username: 'username_new',
                   password: 'password', password_confirmation: 'password'}
      post :create, user: @new_user, skill_ids: @skill.id

      @new_user = User.find_by_username 'username_new'
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 1
    end
  end
end