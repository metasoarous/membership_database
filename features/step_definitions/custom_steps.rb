Then /^I should see (\d+) member field sets$/ do |n|
  page.should have_selector('div.member', :count => n)
end

When /^I follow "([^"]*)" and click OK$/ do |text|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  When %{I follow "#{text}"}
end

# This is admitedly a bit of a hack. Should probably refactor in the long run.
Given /^that membership has (\d+) renewal$/ do |n|
  n.to_i.times {Factory :renewal, :membership_id => Membership.last.id}
end
