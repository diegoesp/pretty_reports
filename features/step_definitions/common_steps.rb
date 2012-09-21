########################################################################
# Common steps for Cucumber
#
# Instance variables
#
# @logged_user = currently logged in user
#
########################################################################

Given /^an admin$/ do  
  admin = User.create!(:email => "admin@prettyreports.com", :password => "password", :admin => true)
  @users ||= Hash.new
  @users["admin"] = admin
end

Given /^an user$/ do  
  user = User.create!(:email => "user@prettyreports.com", :password => "password")
  @users ||= Hash.new
  @users["user"] = user
end

Given /^a sprint release report created by "(.*?)"$/ do |user|

  @report = Report.new
  @report.report_type = "sprint-release"
  @report.title = "title"
  @report.subtitle = "subtitle"
  @report.user = @users[user]
  @report.save!

  @item1 = @report.items.build(:item_type => "feature", 
    :section => "delivered", 
    :title => "As a user I want", 
    :subtitle => "to log into the app",
    :position => 0)
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

Then /^I should see "(.*?)"$/ do |text|
  has_content?(text).should be_true
end

Given /^I create a sprint release report$/ do

  visit new_report_path  

  3.times do |i|
    fill_in("title", :with => "title #{i}")
    fill_in("subtitle", :with => "subtitle #{i}")
    i == 1 ? select("Delivered", :from => "section") : ""
    i == 2 ? select("Not Finished", :from => "section") : ""
    i == 3 ? select("Known Issue", :from => "section") : ""
    page.find("#add-button").click
  end

  page.find("#save-button").click
end


When /^one valid sprint release report should exist$/ do
  sleep(1)
  Report.all.length.should == 1
  Report.first.should be_valid
end

When /^I download the first sprint release report$/ do
  Report.all.length.should == 1
  visit "/reports/#{Report.first.id}?format=pdf"
end

Then /^I should (not )*receive a PDF$/ do |text|
  if text == "not "
    page.text.starts_with?("%PDF-").should be_false
  else
    page.text.starts_with?("%PDF-").should be_true
  end
end

Then /^I should have (\d+) report(s*) in my search page$/ do |number, plural|
  visit reports_path
  # Table list should have as many rows as reports the user has + 1 (for the title row)
  page.find(:xpath, "//table").all(:xpath, ".//tr").length == (number.to_i + 1)
end
