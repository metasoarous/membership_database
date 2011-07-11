Feature: Data entry
  In order to keep the database up to date
  We as the database maintenance folks
  Want to keep be able to enter data and edit data
  
  Scenario: Create new membership
    Given I am on the new membership page
		When I fill in the following:
		 | Home address    | 314 Thimbleberry Lane |
		 | Mailing address | 314 Thimbleberry Lane |
		 | Email           | gfunk@foo.com         |
		 | Phone           | 343-2123              |
		 | City            | Friday Harbor         |
		 | Zip             | 98250                 |
		And I select "Washington" from "State"
		And I press "Create"
		Then 1 memberships should exist
		And I should be on the membership's page
		And I should see "314 Thimbleberry Lane"
		
		
		
	Scenario: Create new membership and members at the same time
		Given I am on the new membership page
		When I fill in the following:
		 | Home address | 314 Thimbleberry Lane |
		 | Email        | gfunk@foo.com         |
		 | Phone        | 343-2123              |
		 | City         | Friday Harbor         |
		 | Zip          | 98250                 |
		 | First name   | Devon                 |
		 | Last name    | Smith                 |
		And I select "Washington" from "State"
		And I press "Create"
		Then 1 memberships should exist
		And 1 members should exist
		And I should be on the membership's page
		And I should see "Devon"
		And I should see "Smith"
		
	
	Scenario: Viewing memberships with no members
    Given the following memberships exist
      | home_address    | email             | phone     |
      | 123 Thibleberry | fungi@friends.com | 2331-1231 |
		When I go to the membership's page
		Then I should see "There are currently no members associated with this membership"
		
		
	@wip
	Scenario: Create fields for additional members
		Given I am on the new membership page
		When I follow "Add Member"
		Then I should see 2 member field sets
		
	
	Scenario: Adding members from Membership page view
		Given a membership exists with id: "1"
		And I am on the membership's page
		When I follow "Add Member"
		Then I should be on the new member page	
		When I fill in the following:
		 | First name   | Devon                    |
		 | Last name    | Smith                    |
		 | Email        | devonsmith@mullberry.com |
		And I press "Submit"
		Then 1 members should exist with membership_id: "1", first_name: "Devon", last_name: "Smith"
		And I should be on the membership's page
		And I should see "Member was successfully created."
		And I should see "Devon" 
		And I should see "Smith"
		And I should see "devonsmith@mullberry.com"

	
	Scenario: Editing membership data
		Given a membership exists with home_address: "312 Thimbleberry"
		And I am on the membership's page
		And I follow "Update Membership"
		When I fill in "The bat cave" for "Home address"
		And I press "Update"
		Then 1 memberships should exist
		And I should see "The bat cave"
		

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete data_entry
    Given the following memberships exist
      | home_address           | email               | phone       | number |
      | 123 Thibleberry        | fungi@friends.com   | 2331-1231   | 1      |
      | 4739 Jack Terrier Lane | jack@foo.com        | 3123-123123 | 2      |
      | 231 Drive North        | north@fest.com      | 113-12424   | 3      |
      | Kristen and Carter     | kcart@killer.dreads | 123 -3 33   | 4      |
		And I am on the memberships page
		And I follow "Destroy Membership Record" within ".membership#1"
		Then I should see "Listing memberships"
		And I should see "Membership successfully destroyed."
		And I should not see "Membership Number 1"
		And 3 memberships should exist
		
	@javascript
	Scenario Outline: Add renewal data
		Given a membership exists
		And I am on the memberships page
		When I follow "Update Membership"
		And I follow "Renewals"
		And I follow "Add Renewal"
		And I fill in the following:
		 | Payment amount | <amount>             |
		 | Notes          | Very smelly payment! |
		And I <check?> "Barter?"
		And I select "02/24/2009" as the date
		And I press "Update"
		Then I should see "Membership successfully updated."
		And I should be on the membership index
		And I should see "<amount_to_see>"
		And I should see "Feb"
		And I should see "2009"
		And I should see "24"
		And 1 renewals should exist
		
		Examples:
		 | amount | check?  | amount_to_see |
		 | 23     | uncheck | $23.00        |
		 |        | check   | barter        |
		 | 34.456 | uncheck | $34.46        |
		
	@javascript
	Scenario: Add multiple renewal dates
		Given a membership exists
		And that membership has 1 renewal
		And I am on the memberships page
		When I follow "Update Membership"
		And I follow "Renewals"
		And I follow "Add Renewal"
		And I fill in "this is a silly note" for "Notes"
		And I press "Update"
		Then I should see "Membership was successfully updated."
		And I should see "this is a silly note"
		And 2 renewals should exist
		
	@javascript
	Scenario: Delete renewal and records in form
		Given a membership exists
		And that membership has 1 renewal
		And I am on the memberships page
		And I follow "Update Membership"
		When I follow "Renewals"
		And I follow "Delete Record" and click OK
		Then I should see "Renewal record successfully deleted."
		And 0 renewals should exist
		
