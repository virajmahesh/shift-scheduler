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

end
