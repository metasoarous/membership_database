Feature: General Navigation
  In order to access data in the database and manage data
  We as the database maintenance folks
  Want to be able to navigate the database tool in an intuitive clean fashion

  
  Scenario: Accessing root page and navigation links
    Given I am on the home page
		Then I should see "Membership Index" within "#nav_sidebar"
		And I should see "Member Index" within "#nav_sidebar"
		And I should see "Add New Membership" within "#nav_sidebar"
		And I should see "Membership Index" within "#nav_sidebar"
		And I should see "Membership Index" within "#nav_sidebar"
		And I should see "Help" within "#nav_sidebar"
		
		
		# Check boxes for headers
		# Search field
		# 	Search by dropdown containing headers currently selected
		# 	+ button generating an additional search box
		# 	Headers also sort buttons
		
	Scenario: Root should show membership index
		Given a membership exists with home_address: "1834 8th St"
		And I am on the home page
		Then I should see "Membership Index"
		And I should see "1834 8th St"
		
	Scenario: Pages should have access to membership index
		Given I am on the home page
		When I follow "Membership Index"
		Then I should be on the memberships page
		
	Scenario: Pages should have access to membership index
		Given I am on the home page
		When I follow "Members Index"
		Then I should be on the members page

			