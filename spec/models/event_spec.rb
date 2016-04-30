require 'spec_helper'

describe Event do

  before :each do
    @user = FactoryGirl.create :user
    @event = FactoryGirl.create :event, user: @user
    @issue = FactoryGirl.create :issue
  end

  describe 'has_issue?' do
    it 'should return true when the event is linked with the issue' do
      @event.issues << @issue
      @event.save

      @event.has_issue?(@issue).should == true
    end

    it 'should retrun false when the event is not linked with the issue' do
      @event.has_issue?(@issue).should == false
    end
  end

end
