Given /^I am an admin user$/ do
  @user = User.create!(:email => "admin@prettyreports.com", :password => "password", :admin => true)
end

Given /^I am an user$/ do
  @user = User.create!(:email => "user@prettyreports.com", :password => "password")
end

Given /^I sign in$/ do
  page.driver.browser.basic_authorize "user", "lacasadelarte"
  visit new_user_session_path
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button("Sign in")
end

Then /^I should see "(.*?)"$/ do |text|
  has_content?(text).should be_true
end

Given /^I create a sprint release report$/ do
  @report = Report.create!(:report_type => "sprint-release",
    :title => "title", 
    :subtitle => "subtitle")
  @item1 = @report.items.build(:item_type => "feature", 
    :section => "delivered", 
    :title => "As a user I want", 
    :subtitle => "to log into the app",
    :position => 0)
  @item2 = @report.items.build(:item_type => "feature", 
    :section => "not-finished", 
    :title => "As a user I want", 
    :subtitle => "to generate a report",
    :position => 0)
  @item3 = @report.items.build(:item_type => "feature", 
    :section => "known-issue", 
    :title => "As an admin I want", 
    :subtitle => "to remind me my password",
    :position => 0)
end

Given /^I ask to create the sprint release report$/ do
  visit "/reports/" + @report.id.to_s + "/download"
end

When /^I download the sprint release report$/ do
  visit "/reports/" + @report.id.to_s + "?format=pdf"
end

Then /^I should receive a PDF$/ do
  page.text.starts_with?("%PDF-").should be_true
end