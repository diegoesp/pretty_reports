########################################################################
# Steps for reports testing
#
# Instance variables
#
# None
#
########################################################################

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
  Report.all.length.should > 0
  visit "/reports/#{Report.first.id}.pdf"
end

When /^I access the first HTML sprint release report$/ do
  visit "/reports/#{Report.first.id}.html"
end

Then /^I should receive an HTML report$/ do
  has_content?("Delivered Features").should be_true
end

Then /^download of the first sprint release report should fail$/ do
  Report.all.length.should > 0
  lambda do
    visit "/reports/#{Report.first.id}.pdf"
  end.should raise_error()
end

Then /^I should have (\d+) report(s*) in my search page$/ do |number, plural|
  visit reports_path
  # Table list should have as many rows as reports the user has + 1 (for the title row)
  page.find(:xpath, "//table").all(:xpath, ".//tr").length.should == (number.to_i + 1)
end

Then /^I should receive a PDF report$/ do
  page.text.starts_with?("%PDF-").should be_true
  page.text.length.should > 256
end