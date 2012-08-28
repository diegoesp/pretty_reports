Given /^I am user "(.*?)" with an account$/ do |email|  
  @user = User.create!(:email => email, :password => "password", :admin => true)
end

Given /^I sign in$/ do
  page.driver.browser.basic_authorize "user", "lacasadelarte"
  visit new_user_session_path
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button("Sign in")
end

Then /^I should see "(.*?)"$/ do |text|
  has_content?(text)
end