require 'spec_helper'

describe Searcher do
	
	before :all do
		@mems1 = Factory :membership, :home_address => "123 Pickleberry"
		@mems2 = Factory :membership, :mailing_address => "123 Pickleberry"
		@mems3 = Factory :membership
	end
	
	describe "when searching for address" do
		before :all do
			@search = Searcher.new(:field => :address, :query => "123 Pickleberry")
		end
		it "should return membership results when there is a match for either home or mailing address" do
			@search.results.should include?(@mems1)
			@search.results.should include?(@mems2)
		end
		it "should not return membership results that fo not match the given address" do
			@search.results.should_not include?(@mems3)
		end
	end
	
	describe "searching by fields belonging to members and memberships - " do
		describe "searching by email" do
			it "should return both members and memberships" do
				
			end
		end
			
		end
	end
end
