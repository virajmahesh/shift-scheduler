require 'spec_helper'

describe SuperUser do

  describe 'create' do
    it 'should correctly set type' do
      @super_user = FactoryGirl.create :super_user

      @super_user.type.should == 'SuperUser'
      @super_user.is_super_user?.should == true
    end
  end

end
