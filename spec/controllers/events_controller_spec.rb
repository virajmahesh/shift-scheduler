require 'spec_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe EventsController do

  before :each do
    @user = FactoryGirl.create :user
    @super_user = FactoryGirl.create :super_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'GET new' do
    it 'should redirect to the login page when no user is logged in' do
      get :new
      response.should redirect_to new_user_session_path
    end
  end

  describe 'POST create' do
    it 'should not allow an event to be created when no user is logged in' do
      @init_num_events = Event.all.length
      @event = {event_date: '10/03/2017', event_name: 'Support Hillary',
                location: 'Berkeley', candidate: 'Hillary',
                start_time: '10:00 AM', end_time: '11:00 AM'}
      post :create, event: @event

      Event.all.length.should == @init_num_events
    end

    it 'should allow an event to be created when a user is logged in' do
      sign_in @user
      @init_num_events = Event.all.length
      @event = {event_date: '10/03/2017', event_name: 'Support Hillary',
                location: 'Berkeley', candidate: 'Hillary',
                start_time: '10:00 AM', end_time: '11:00 AM'}

      post :create, event: @event

      Event.all.length.should == @init_num_events + 1
      (Event.find_by event_name: 'Support Hillary').nil?.should == false
    end

    it 'should allow super users to create events' do
      sign_in @super_user
      @init_num_events = Event.all.length
      @event = {event_date: '10/03/2017', event_name: 'Support Hillary',
                location: 'Berkeley', candidate: 'Hillary',
                start_time: '10:00 AM', end_time: '11:00 AM'}

      post :create, event: @event

      Event.all.length.should == @init_num_events + 1
      (Event.find_by event_name: 'Support Hillary').nil?.should == false
    end

  end

  describe 'PUT update' do
    it 'should not allow an event to be updated when no user is logged in' do
      @event = FactoryGirl.create :event, user: @user, event_name: 'Support Hillary'
      put :update, id: @event.id, event: {event_name: 'Support Hillary Today'}

      @updated_event = Event.find_by_id @event.id
      @updated_event.event_name.should == 'Support Hillary'
    end

    it 'should not allow an event to be updated when a user other than the event creator is logged in' do
      @new_user = FactoryGirl.create :user

      sign_in @new_user
      @event = FactoryGirl.create :event, user: @user, event_name: 'Support Hillary'
      put :update, id: @event.id, event: {event_name: 'Support Hillary Today'}

      @updated_event = Event.find @event.id
      @updated_event.event_name.should == 'Support Hillary'
    end

    it 'should allow an event to be updated when the event creator is logged in' do
      sign_in @user
      @event = FactoryGirl.create :event, user: @user, event_name: 'Support Hillary'
      put :update, id: @event.id, event: {event_name: 'Support Hillary Today'}

      @event.reload
      @event.event_name.should == 'Support Hillary Today'
    end

    it "should allow a super user to edit another user's event" do
      sign_in @super_user

      @event = FactoryGirl.create :event, user: @user, event_name: 'Support Hillary'
      put :update, id: @event.id, event: {event_name: 'Support Hillary Today'}

      @event.reload
      @event.event_name.should == 'Support Hillary Today'
    end

  end

  describe 'DELETE destroy' do
    it 'should not allow an event to be deleted when no user is logged in' do
      @event = FactoryGirl.create :event, user: @user

      @init_num_events = Event.all.length
      delete :destroy, id: @event.id

      Event.all.length.should == @init_num_events
    end

    it 'should not allow an event to be deleted when the event creator is not logged in' do
      @event = FactoryGirl.create :event, user: @user
      @new_user = FactoryGirl.create :user

      sign_in @new_user

      @init_num_events = Event.all.length
      delete :destroy, id: @event.id

      Event.all.length.should == @init_num_events
    end

    it 'should allow an event to be deleted when the event creator is logged in' do
      @event = FactoryGirl.create :event, user: @user

      sign_in @user

      @init_num_events = Event.all.length
      delete :destroy, id: @event.id

      Event.all.length.should == @init_num_events - 1
    end

    it 'should allow an event to be deleted when superuser is logged in' do
      @event = FactoryGirl.create :event, user: @user

      sign_in @super_user

      @init_num_events = Event.all.length
      delete :destroy, id: @event.id

      Event.all.length.should == @init_num_events - 1
    end

    it 'should destroy all shifts and event issues associated with an event' do
      sign_in @user
      @issue = FactoryGirl.create :issue
      @event = FactoryGirl.create :event, user: @user
      @shift = FactoryGirl.create :shift, event: @event

      @event_issue = EventIssue.create event: @event, issue: @issue

      delete :destroy, id: @event.id

      Shift.exists?(id: @shift.id).should == false
      EventIssue.exists?(id: @event_issue.id).should == false

      # Should not delete issue
      Issue.exists?(id: @issue.id).should == true
    end
  end

  describe 'POST transfer'do

    before :each do
      @new_user = FactoryGirl.create :user
      @event = FactoryGirl.create :event, user: @user
    end

    it 'should allow superusers to transfer events to a valid user by username' do
      sign_in @super_user
      post :transfer, id: @event.id, login: @new_user.username

      @event.reload
      @event.user.should == @new_user
    end

    it 'should allow superusers to transfer events to a valid user by email' do
      sign_in @super_user
      post :transfer, id: @event.id, login: @new_user.email

      @event.reload
      @event.user.should == @new_user
    end

    it 'should not allow superusers to transfer events to users with invalid credentials' do
      sign_in @super_user
      post :transfer, id: @event.id, login: @user.email + 'fail'

      @event.reload
      @event.user.should == @user
    end

  end
end