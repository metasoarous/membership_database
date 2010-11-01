Then /^I should see (\d+) member field sets$/ do |n|
  page.should have_selector('div.member', :count => n )
end
