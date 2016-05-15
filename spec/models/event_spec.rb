require 'spec_helper'

describe Event do

  describe 'has_issue?' do
    before :each do
      @user = FactoryGirl.create :user
      @event = FactoryGirl.create :event, user: @user
      @issue = FactoryGirl.create :issue
    end

    it 'should return true when the event is linked with the issue' do
      @event.issues << @issue
      @event.save

      @event.has_issue?(@issue).should == true
    end

    it 'should return false when the event is not linked with the issue' do
      @event.has_issue?(@issue).should == false
    end
  end

  describe 'future_events' do
    it 'should return events sorted in chronological order' do
      @user = FactoryGirl.create :user
      @event_1 = FactoryGirl.create :event, user: @user, event_date: 10.days.from_now
      @event_2 = FactoryGirl.create :event, user: @user, event_date: 5.days.from_now

      Event.future_events.first.should == @event_2
      Event.future_events.second.should == @event_1
    end
  end

end
