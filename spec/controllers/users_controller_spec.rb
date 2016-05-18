require 'spec_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create :user
    @new_user = FactoryGirl.create :user
    @event = FactoryGirl.create :event, user: @user
    @shift = FactoryGirl.create :shift, event: @event

    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def current_user
    subject.current_user
  end

  describe 'GET join_shift' do
    it 'should allow a user that is logged in to sign up for a shift' do
      sign_in @new_user
      get :join_shift, id: @shift
      @new_user.signed_up_for?(@shift).should == true
    end

    it 'should not allow a user that is not logged in to sign up for a shift' do
      get :join_shift, id: @shift
      @new_user.signed_up_for?(@shift).should == false
    end

    it 'should not allow a user to sign up multiple times for the same shift' do
      sign_in @new_user
      VolunteerCommitment.create user: @new_user, shift: @shift
      @old_commitments = VolunteerCommitment.all.length

      get :join_shift, id: @shift
      VolunteerCommitment.all.length.should == @old_commitments
    end
  end
end