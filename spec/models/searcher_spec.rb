require 'spec_helper'

describe Searcher do
	
	# Note that search results are meant to return memberships, not members,
	# even in these cases.
	describe "when searching by member info" do
		before :each do 
			@mems1 = Factory :membership, :id => 1
			@mems2 = Factory :membership, :id => 2
			@mems3 = Factory :membership, :id => 3
			@mems4 = Factory :membership, :id => 4
			@mems5 = Factory :membership, :id => 5
			
			@mem1 = Factory :member, :first_name => "Ben", :last_name => "Stiller", :membership_id => 1
			@mem2 = Factory :member, :first_name => "Ben", :last_name => "Rosas", :membership_id => 2
			@mem3 = Factory :member, :first_name => "Benjamin", :last_name => "Cricket", :membership_id => 3
			@mem4 = Factory :member, :first_name => "bEn", :last_name => "Stiller", :membership_id => 4
			@mem5 = Factory :member, :first_name => "Daniel", :last_name => "Rosas", :membership_id => 5
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
			before :each do
				@mems1 = Factory :membership, :home_address => "123 Pickleberry"
				@mems2 = Factory :membership, :mailing_address => "123 Pickleberry"
				@mems3 = Factory :membership
				
				@search = Searcher.new(:field => :address, :query => "123 Pickleberry")
			end
			it "should return membership results when there is a match for home address" do
				@search.results.should include(@mems1)
			end
			it "should return membership results when there is a match for mailing address" do
				@search.results.should include(@mems2)
			end
			it "should not return membership results that do not match the given address" do
				@search.results.should_not include(@mems3)
			end
		end
	end
	
	
	describe "when searching by fields shared by members and memberships - " do
		before :each do 
			@mems1 = Factory :membership, :id => 1
			@mems2 = Factory :membership, :email => "foo@bar.com", :id => 2
			@mems3 = Factory :membership, :email => "foo@fighters.com", :id => 3
			
			@mem1 = Factory :member, :email => "foo@bar.com", :membership_id => 1
			@mem2 = Factory :member, :phone => "123-4567", :membership_id => 2
			@mem3 = Factory :member, :membership_id => 3
		end
		describe "searching by email" do
			before :all do
				@search = Searcher.new :field => "email", :query => "foo@bar.com"
			end
			it "should memberships that match on member fields" do
				@search.results.should include(@mems1)
			end
			it "should memberships that match on membership fields" do
				@search.results.should include(@mems2)
			end
			it "should not return near matches" do
				@search.results.should_not include(@mems3)
			end
		end
		describe "searching by phone" do
			before :all do
				@search = Searcher.new :field => "email", :query => "foo@bar.com"
			end
			it "should memberships that match on member fields" do
				@search.results.should include(@mems1)
			end
			it "should memberships that match on membership fields" do
				@search.results.should include(@mems2)
			end
			it "should not return near matches" do
				@search.results.should_not include(@mems3)
			end
		end
	end
	
	describe "when searching by renewal date" do
		before :each do
			@mems1 = Factory :membership
			@mems2 = Factory :membership
			@mems3 = Factory :membership
			
			@renewal11 = Factory :renewal, :date => Date.civil(2004,02,01), :membership => @mems1
			@renewal12 = Factory :renewal, :date => Date.civil(2005,02,01), :membership => @mems1
			@renewal21 = Factory :renewal, :date => Date.civil(2005,02,01), :membership => @mems2
			@renewal22 = Factory :renewal, :date => Date.civil(2006,02,01), :membership => @mems2
			@renewal31 = Factory :renewal, :date => Date.civil(2006,02,01), :membership => @mems3
			@renewal32 = Factory :renewal, :date => Date.civil(2007,02,01), :membership => @mems3
			
			@search = Searcher.new :field => :renewal_date, :query => "1/1/2006 - 1/1/2007"
		end
		it "should catch memberships with a first renewal in the range" do
			@search.results.should include(@mems3)
		end
		it "should catch memberships with a last renewal in the range" do
			@search.results.should include(@mems2)
		end
		it "should not catch memberships with no renewals in the range" do
			@search.results.should_not include(@mems1)
		end
		it "should work with chronic ranges" do
			results = Searcher.new(:field => :renewal_date, :query => "May 2006 - today").results
			results.should include(@mems3)
			results.should_not include(@mems2)
			results.should_not include(@mems1)
		end
	end	
end
