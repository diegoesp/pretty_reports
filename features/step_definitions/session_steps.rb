########################################################################
# Steps for session testing
#
# Instance variables
#
# None
#
########################################################################

Given /^I access my preferences page$/ do
  visit "/users/#{@logged_user.id}/edit"
end

Given /^I change my preferences first name and last name to "(.*?)" and "(.*?)"$/ do |first_name, last_name|
  fill_in "user_last_name", :with => last_name
  fill_in "user_first_name", :with => first_name
  fill_in "user_password", :with => "password"
  fill_in "user_password_confirmation", :with => "password"
  click_button("Save")
end
