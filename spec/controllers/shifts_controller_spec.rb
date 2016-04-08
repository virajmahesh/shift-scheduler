require 'spec_helper'

describe ShiftsController do

  before :each do
    @user = FactoryGirl.create :user
    @event = FactoryGirl.create :event, user: @user
    @request.env["devise.mapping"] = Devise.mappings[:user]
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
  end

  describe 'PUT update' do
    it 'should not allow a shift to be updated when no user is logged in' do
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      shift = Shift.find @shift.id
      shift.role.should_not == 'Updated Tabling'
      shift.role.should == @shift.role
    end

    it 'should not allow a shift to be updated when a user other than the event creator is logged in' do
      @new_user = FactoryGirl.create :user

      sign_in @new_user
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      shift = Shift.find @shift.id
      shift.role.should_not == 'Updated Tabling'
      shift.role.should == @shift.role
    end

    it 'should allow a shift to be updated when the event creator is logged in' do
      sign_in @user
      @shift = FactoryGirl.create :shift, event: @event
      put :update, event_id: @event.id, id: @shift.id, shift: {role: 'Updated Tabling'}

      shift = Shift.find @shift.id
      shift.role.should == 'Updated Tabling'
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

    it 'should allow a shift to be destroyed whena user other than the event creator is logged in' do
      sign_in @user
      @shift = FactoryGirl.create :shift, event: @event
      delete :destroy, event_id: @event.id, id: @shift.id

      shift = Shift.find_by id: @shift.id
      shift.nil?.should == true
    end
  end
end