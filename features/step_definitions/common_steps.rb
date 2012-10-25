########################################################################
# Common steps for Cucumber
#
# Instance variables
#
# @logged_user = currently logged in user
# @users = hash that contains two instantiated users: "admin" and "user"
#
########################################################################

Given /^an admin$/ do  
  admin = User.create!(:first_name => "John", :last_name => "Admin", :email => "admin@prettyreports.com", :password => "password", :admin => true)
  @users ||= Hash.new
  @users["admin"] = admin
end

Given /^an user$/ do  
  user = User.create!(:first_name => "Peter", :last_name => "User", :email => "user@prettyreports.com", :password => "password")
  @users ||= Hash.new
  @users["user"] = user
end

Given /^I sign out$/ do 
  visit users_sign_out_path
  @logged_user = nil
end

Given /^I sign in as "(.*?)"$/ do |user|
  visit new_user_session_path
  fill_in "user_email", :with => @users[user].email
  fill_in "user_password", :with => @users[user].password
  click_button("Sign in")
  @logged_user = @users[user]
end

Then /^I should be required to sign$/ do
  has_content?("You need to sign in").should be_true
end

Then /^I should see "(.*?)"$/ do |text|
  has_content?(text).should be_true
end

Given /^I access the home page$/ do
  visit "/"
end