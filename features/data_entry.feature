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
		 | State           | Washington            |
		 | Zip             | 98250                 |

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
		 | State        | Washington            |
		 | Zip          | 98250                 |
		 | First name   | Devon                 |
		 | Last name    | Smith                 |
		
		And I press "Create"
		Then 1 memberships should exist
		And 1 members should exist
		And I should be on the membership's page
		And I should see "Devon"
		And I should see "Smith"
		
	
	Scenario: Viewing memberships with no members
    Given the following memberships exist
      | home_address           | email               | phone       |
      | 123 Thibleberry        | fungi@friends.com   | 2331-1231   |
		
		When I go to the membership's page
		Then I should see "There are currently no members associated with this membership"
		
	@javascrit
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
		And I follow "Edit Membership Data"
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
      | home_address           | email               | phone       |
      | 123 Thibleberry        | fungi@friends.com   | 2331-1231   |
      | 4739 Jack Terrier Lane | jack@foo.com        | 3123-123123 |
      | 231 Drive North        | north@fest.com      | 113-12424   |
      | Kristen and Carter     | kcart@killer.dreads | 123 -3 33   |

    When I delete the 2nd membership
    Then I should see the following memberships:
	    | Home address           | Email               | Phone       |
	    | 123 Thibleberry        | fungi@friends.com   | 2331-1231   |
	    | 4739 Jack Terrier Lane | jack@foo.com        | 3123-123123 |
	    | Kristen and Carter     | kcart@killer.dreads | 123 -3 33   |
