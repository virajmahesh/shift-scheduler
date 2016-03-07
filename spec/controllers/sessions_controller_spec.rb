require 'spec_helper'

describe SessionsController do
  describe 'logout action' do

    it 'should logout a user that is logged in' do
      @request.session[:user_id] = rand
      delete :destroy
      @request.session[:user_id].nil?.should == true
    end
  end
end