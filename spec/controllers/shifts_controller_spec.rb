require 'spec_helper'

describe ShiftsController do

  before :each do
    @user = FactoryGirl.create :user
    @super_user = FactoryGirl.create :super_user
    @event = FactoryGirl.create :event, user: @user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'POST create' do
    it 'should not allow a shift to be created when no user is logged in' do
      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}
      post :create, event_id: @event.id, shift: @shift

      @event.shifts.length.should == 0
    end

    it 'should not allow a shift to be created without a role' do
      sign_in @user
      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', has_limit: 'false'}
      post :create, event_id: @event.id, shift: @shift

      @event.shifts.length.should == 0
      flash.alert.should == "Role can't be blank"
    end

    it 'should not allow a shift to be created when a user other than the event creator is not logged in' do
      @new_user = FactoryGirl.create :user
      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}

      sign_in @new_user
      post :create, event_id: @event.id, shift: @shift

      @event.shifts.length.should == 0
    end

    it 'should allow a shift to be created when the event creator is logged in' do
      sign_in @user
      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}
      post :create, event_id: @event.id, shift: @shift

      @event.shifts.length.should == 1
    end

    it 'should allow a shift to be created when super user is logged in' do
      sign_in @super_user
      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}
      post :create, event_id: @event.id, shift: @shift

      @event.shifts.length.should == 1
    end

    it 'should notify a user when a shift with matching skills is created' do
      sign_in @user

      @event = FactoryGirl.create :event, user: @user, event_date: 3.days.from_now
      @new_user = FactoryGirl.create :user

      @skill_1 = FactoryGirl.create :skill
      @skill_2 = FactoryGirl.create :skill
      @skill_3 = FactoryGirl.create :skill

      UserSkill.create user: @user, skill: @skill_1
      UserSkill.create user: @user, skill: @skill_2
      UserSkill.create user: @new_user, skill: @skill_3

      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}

      post :create, event_id: @event.id, shift: @shift, skill_ids: [@skill_1.id, @skill_2.id].join(',')

      @shift = Shift.find_by_role 'Tabling'

      MatchingShiftActivity.where(owner_id: @user, shift: @shift).count.should == 1
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 0
    end

    it 'should not notify a user when a shift with matching skills is created for an event in the past' do
      sign_in @user

      @event = FactoryGirl.create :event, user: @user, event_date: 3.days.ago
      @new_user = FactoryGirl.create :user

      @skill_1 = FactoryGirl.create :skill
      @skill_2 = FactoryGirl.create :skill
      @skill_3 = FactoryGirl.create :skill

      UserSkill.create user: @user, skill: @skill_1
      UserSkill.create user: @user, skill: @skill_2
      UserSkill.create user: @new_user, skill: @skill_3

      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}

      post :create, event_id: @event.id, shift: @shift, skill_ids: [@skill_1.id, @skill_2.id].join(',')

      @shift = Shift.find_by_role 'Tabling'

      MatchingShiftActivity.where(owner_id: @user, shift: @shift).count.should == 0
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 0
    end
  end

  describe 'PUT update' do
    it 'should not allow a shift to be updated when no user is logged in' do
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      @shift.reload
      @shift.role.should_not == 'Updated Tabling'
      @shift.role.should == @shift.role
    end

    it 'should not allow a shift to be updated when a user other than the event creator is logged in' do
      @new_user = FactoryGirl.create :user

      sign_in @new_user
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      @shift.reload
      @shift.role.should_not == 'Updated Tabling'
      @shift.role.should == @shift.role
    end

    it 'should allow a shift to be updated when the event creator is logged in' do
      sign_in @user
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      @shift.reload
      @shift.role.should == 'Updated Tabling'
    end

    it 'should allow a shift to be updated when super user is logged in' do
      sign_in @super_user
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      @shift.reload
      @shift.role.should == 'Updated Tabling'
    end

    it 'should notify a user when a shift is updated to have matching skills' do
      sign_in @user
      @new_user = FactoryGirl.create :user

      @skill_1 = FactoryGirl.create :skill
      @skill_2 = FactoryGirl.create :skill
      @skill_3 = FactoryGirl.create :skill

      UserSkill.create user: @user, skill: @skill_1
      UserSkill.create user: @user, skill: @skill_2
      UserSkill.create user: @new_user, skill: @skill_3

      @shift = {start_time: '10:00 PM', end_time: '10:10 PM', role: 'Tabling',
                has_limit: 'false'}

      # Create the shift.
      post :create, event_id: @event.id, shift: @shift, skill_ids: [@skill_1.id, @skill_2.id].join(',')

      @shift = Shift.find_by_role 'Tabling'

      MatchingShiftActivity.where(owner_id: @user, shift: @shift).count.should == 1
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 0

      # Update the shift skills.
      put :update, event_id: @event.id, id: @shift.id, shift: {end_time: '10:20 PM'},
                   skill_ids: [@skill_1.id, @skill_2.id, @skill_3.id].join(',')

      @shift = Shift.find_by_role 'Tabling'

      MatchingShiftActivity.where(owner_id: @user, shift: @shift).count.should == 1
      MatchingShiftActivity.where(owner_id: @new_user, shift: @shift).count.should == 1
    end
  end

  describe 'DELETE destory' do
    it 'should not allow a shift to be destroyed when no user is logged in' do
      @shift = FactoryGirl.create :shift, event: @event
      delete :destroy, event_id: @event.id, id: @shift.id

      shift = Shift.find_by id: @shift.id
      shift.nil?.should == false
    end

    it 'should not allow a shift to be destroyed whena user other than the event creator is logged in' do
      @new_user = FactoryGirl.create :user

      sign_in @new_user
      @shift = FactoryGirl.create :shift, event: @event
      delete :destroy, event_id: @event.id, id: @shift.id

      shift = Shift.find_by id: @shift.id
      shift.nil?.should == false
    end

    it 'should allow a shift to be destroyed when the event creator is logged in' do
      sign_in @user
      @shift = FactoryGirl.create :shift, event: @event
      delete :destroy, event_id: @event.id, id: @shift.id

      shift = Shift.find_by id: @shift.id
      shift.nil?.should == true
    end

    it 'should allow a shift to be destroyed when a user other than the event creator is logged in' do
      sign_in @super_user
      @shift = FactoryGirl.create :shift, event: @event
      delete :destroy, event_id: @event.id, id: @shift.id

      shift = Shift.find_by id: @shift.id
      shift.nil?.should == true
    end
  end
end