require 'spec_helper'

describe SessionsController do

  describe "GET 'toggle_membership_view'" do
    it "should be successful" do
      get 'toggle_membership_view'
      response.should be_success
    end
  end

end
