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

  describe 'POST create' do
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

    it 'should not notify users about past shifts that match their skills' do
      @skill = FactoryGirl.create :skill
      @event = FactoryGirl.create :event, user: @user, event_date: 3.days.ago
      @shift = FactoryGirl.create :shift, event: @event
      ShiftSkill.create shift: @shift, skill: @skill

      # Sign up as a new user
      @new_user = {email: 'email@email.com', username: 'username_new',
                   password: 'password', password_confirmation: 'password'}
      post :create, user: @new_user, skill_ids: @skill.id

      @new_user = User.find_by_username 'username_new'
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 0
    end
  end

  describe 'PUT update' do
    it 'should update user information when current password is provided' do
      @new_user = FactoryGirl.create :user, password: 'testpass',
                                           password_confirmation: 'testpass'

      sign_in @new_user
      @skill = FactoryGirl.create :skill
      @issue = FactoryGirl.create :issue

      @updated_user = {city: 'Oakland', state: 'CA', email: 'email@gmail.com',
                       current_password: 'testpass', zip_code: '12345'}
      put :update, user: @updated_user, skill_ids: @skill.id, issue_ids: @issue.id

      @new_user.reload
      @new_user.state.should == 'CA'
      @new_user.city.should == 'Oakland'
      @new_user.zip_code.should == 12345
      @new_user.email.should == 'email@gmail.com'
      @new_user.skills.length.should == 1
      @new_user.issues.length.should == 1
    end
  end
end