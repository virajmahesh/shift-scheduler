require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe EventsController do

  before :each do
    @user = FactoryGirl.create :user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'POST create' do
    it 'should not allow an event to be created when no user is logged in' do
      @init_num_events = Event.all.length
      @event = {event_date: '10/03/2017', event_name: 'Support Hillary',
                location: 'Berkeley', candidate: 'Hillary'}
      post :create, event: @event

      Event.all.length.should == @init_num_events
    end


    it 'should allow a shift to be created when a user is logged in' do
      sign_in @user
      @init_num_events = Event.all.length
      @event = {event_date: '10/03/2017', event_name: 'Support Hillary',
                location: 'Berkeley', candidate: 'Hillary'}
      post :create, event: @event

      Event.all.length.should == @init_num_events + 1
      (Event.find_by event_name: 'Support Hillary').nil?.should == false
    end
  end

  describe 'PUT update' do
    it 'should not allow an event to be updated when no user is logged in' do
      @event = FactoryGirl.create :event, user: @user, event_name: 'Support Hillary'
      put :update, id: @event.id, event: {event_name: 'Support Hillary Today'}

      @updated_event = Event.find @event.id
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

      @updated_event = Event.find @event.id
      @updated_event.event_name.should == 'Support Hillary Today'
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

    it 'should allow an event to be deleted when the event creator is not logged in' do
      @event = FactoryGirl.create :event, user: @user

      sign_in @user

      @init_num_events = Event.all.length
      delete :destroy, id: @event.id

      Event.all.length.should == @init_num_events - 1
    end
  end
end