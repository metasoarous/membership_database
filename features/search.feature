Feature: Search
	In order to access data in the database and manage data
	We as the database maintenance folks
	Want to be able to search for membership and member database records in a easy fashion
	
	# Set up of some dummy memberships and members for ourselves. 
	Background: 
	  Given the following memberships exist
	    | home_address           | email               | phone        | number | id |
	    | 123 Thimbleberry       | fungi@friends.com   | 123-4567     | 13     | 1  |
	    | 4739 Jack Terrier Lane | jack@foo.com        | 123-9999     | 24     | 2  |
	    | 231 Drive North        | north@fest.com      | 456-7890     | 35     | 3  |
	    | Kristen and Carter     | kcart@killer.dreads | 345-123-9000 | 46     | 4  |
	
		And the following members exist
		 | first_name | last_name | email                | phone        | membership_id |
		 | George     | Winston   | george@foo.com       | 317-4181     | 1             |
		 | George     | Nelson    | georgenelson@bar.com | 206-451-9000 | 1             |
		 | Winston    | Churchill | winston@foo.com      | 370-1234     | 2             |
		 | Leanna     | Churchill | leanna@foo.com       |              | 2             |
		 | Dianne     | Suthers   | dainne@foo.com       |              | 3             |
	
	@passing
	Scenario: Searching by last name only
		Given I am on the home page
		When I select "Last Name" from "Search by"
		And I fill in "Winston" for "Query"
		And I press "Search"
		Then I should see "There is 1 match for your query."
		Then I should see "George"
		And I should see "george@foo.com"
		And I should see "317-4181"
		And I should see "Winston"
		And I should see "Nelson"
		And I should not see "Dianne"
		And I should see "123 Thimbleberry"
		And I should see "123-4567"
		
	# Should probably spec out what happens to numbers that are similar - 224 and 24.
	@passing
	Scenario: Searching by membership number
		Given I am on the home page
		When I select "Membership Number" from "Search by"
		And I fill in "24" for "Query"
		And I press "Search"
		Then I should see "There is 1 match for your query."
		And I should see "4739 Jack Terrier Lane"
		
	@passing
	Scenario: Searching by blank field returns error
		Given I am on the home page
		When I fill in "This shouldn't work" for "Query"
		And I press "Search"
		Then I should see "Make sure you select a field for the searcher"
		
		
