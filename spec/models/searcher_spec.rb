require 'spec_helper'

describe Searcher do
	
	before :all do
		@mems1 = Factory :membership, :home_address => "123 Pickleberry", :id => 1
		@mems2 = Factory :membership, :mailing_address => "123 Pickleberry", :id => 2
		@mems3 = Factory :membership, :email => "foo3@bar.com", :id => 3
		@mems4 = Factory :membership, :phone => "425-7173", :id => 4
		@mems5 = Factory :membership, :id => 5
		@mems6 = Factory :membership, :id => 6
		
	end
	
	# Note that search results are meant to return memberships, not members,
	# even in these cases.
	describe "when searching by member info" do
		before :all do 
			@mem1 = Factory :member, :first_name => "Ben", :last_name => "Stiller", :membership_id => 1
			@mem2 = Factory :member, :first_name => "Ben", :last_name => "Rosas", :membership_id => 2
			@mem3 = Factory :member, :first_name => "Benjamin", :last_name => "Cricket", :membership_id => 3
			@mem4 = Factory :member, :first_name => "bEn", :last_name => "Stiller", :membership_id => 4
			@mem5 = Factory :member, :first_name => "Daniel", :last_name => "Rosas", :membership_id => 5
			@mem6 = Factory :member, :first_name => "Bloomberg", :last_name => "Rogers", :membership_id => 6
		end
		# This specific test batch is a little more thorough than the rest in
		# testing for case insensitivity and such
		describe "using first_name" do
			before :all do
				@search = Searcher.new(:field => :first_name, :query => "Ben")
			end
			it "should return all exact matches" do
				@search.results.should include(@mems1)
				@search.results.should include(@mems2)
			end
			it "should return incomplete matches" do
				@search.results.should include(@mems3)
			end
			it "should return matches case insensitively" do
				# debugger
				@search.results.should include(@mems4)
			end
			it "should not return non matches" do
				@search.results.should_not include(@mems5)
			end
		end
		describe "using last_name" do
			before :all do
				@search = Searcher.new :field => :last_name, :query => "Rosas"
			end
			it "should return all exact matches" do
				@search.results.should include(@mems2)
				@search.results.should include(@mems5)
			end
			it "should not return non mathces" do
				@search.results.should_not include(@mems1)
				@search.results.should_not include(@mems3)
			end
		end
	end
	
	describe "when searching by membership info" do
		describe "using address" do
			before :all do
				@search = Searcher.new(:field => :address, :query => "123 Pickleberry")
			end
			it "should return membership results when there is a match for either home or mailing address" do
				@search.results.should include(@mems1)
				@search.results.should include(@mems2)
			end
			it "should not return membership results that do not match the given address" do
				@search.results.should_not include(@mems3)
			end
		end
	end
	
	
	describe "when searching by fields shared by members and memberships - " do
		before :all do 
			@mem1 = Factory :member, :email => "foo1@bar.com", :membership_id => 1
			@mem2 = Factory :member, :phone => "123-4567", :membership_id => 2
			@mem3 = Factory :member, :membership_id => 3
			@mem4 = Factory :member, :membership_id => 4
			@mem5 = Factory :member, :membership_id => 5
		end
		describe "searching by email" do
			it "should return both members and memberships" do
				
			end
		end
	end
end
