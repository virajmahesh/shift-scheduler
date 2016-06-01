require 'spec_helper'

describe Shift do

  before :each do
    @user = FactoryGirl.create :user
    @event = FactoryGirl.create :event, user: @user
    @shift = FactoryGirl.create :shift, event: @event

    @skill = FactoryGirl.create :skill
  end

  describe 'has_skill?' do
    it 'should return true when the shift is linked with the skill' do
      @shift.skills << @skill
      @shift.save

      @shift.has_skill?(@skill).should == true
    end

    it 'should retrun false when the shift is not linked with the skill' do
      @shift.has_skill?(@skill).should == false
    end
  end

  describe 'duplicate' do
    before :each do
      @shift.skills << @skill
      @shift.save
    end

    it 'should return a shift object that is persisted in the db' do
      @new_user = FactoryGirl.create :user
      @new_event = FactoryGirl.create :event, user: @user

      @new_shift = @shift.duplicate @new_event

      @new_shift.nil?.should == false
      @new_shift.persisted?.should == true

      @new_shift.event.should == @new_event
      @new_shift.skills.should == @shift.skills
    end
  end

  describe 'validate :limit_settings' do
    it 'should check that limit is not blank if has limit is checked' do
      @shift = Shift.create role: 'Tabling', start_time: '10:00 AM', end_time: '10:30 AM',
                            has_limit: true

      @shift.valid?.should == false
      @shift.errors.full_messages.first.should == "Limit can't be blank if has limit is checked"
    end

    it 'should check that limit is blank if has limit is not checked' do
      @shift = Shift.create role: 'Tabling', start_time: '10:00 AM', end_time: '10:30 AM',
                            has_limit: false, limit: 5

      @shift.valid?.should == false
      @shift.errors.full_messages.first.should == "Limit must be blank if has limit is not checked"
    end
  end

end
