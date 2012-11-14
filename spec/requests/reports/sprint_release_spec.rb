require "spec_helper"
require "support/session.rb"

describe "Sprint Release Report" do

  before(:each)  do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    sign_in @user
  end
  
  it "should allow a User to create a new report", :js => true do
    
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

  it "should allow a user to generate an HTML for a report" do    
    @report = FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)

    visit "/reports/#{@report.id}.html"
    page.should have_content "Delivered Features"
  end

  it "should not allow a user to generate a report created by other user" do    
    @report = FactoryGirl.create(:report, user: @admin)
    FactoryGirl.create(:item, report: @report)

    Report.all.length.should > 0
    lambda do
      visit("/reports/#{@report.id}.pdf")
      # Under rake tasks exceptions are not raised, but returned as page text
      if page.text.include?("Action Controller: Exception caught")
        raise "Exception caught"
      end

    end.should raise_error()
  end

  it "should required a user to be logged in before generating a PDF" do
    @report = FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)

    sign_out

    visit "/reports/#{@report.id}.pdf"
    page.should have_content("You need to sign in")
  end
  
end