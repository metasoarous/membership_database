require 'spec_helper'

describe Membership do
	describe "creation" do
		it "should work" do
			Factory :membership
			Membership.count.should == 1
		end
	end
	describe "deletion" do
		before :each do
			@mems = Factory :membership, :id => 1
		end
		it "should work" do
			@mems.destroy
			Membership.count.should == 0
		end
		it "should destroy associated members" do
			Factory :member, :membership_id => 1
			Factory :member, :membership_id => 1
			Factory :member, :membership_id => 1
			@mems.destroy
			Member.count.should == 0
		end
	end
end