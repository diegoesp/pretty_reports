require "spec_helper"
require "support/session.rb"

describe "Report index" do

  before(:each)  do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    sign_in @user
  end
  
  it "should show all report created by a user" do
    # Create report 1
    FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)
    # Create report 2
    FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)
    # Create report 3
    FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)

    visit reports_path
    page.find(:xpath, "//table").all(:xpath, ".//tr").length.should == (3 + 1)
  end

  it "should show only the reports that belong to the user" do
    # Create report 1
    FactoryGirl.create(:report, user: @user)
    FactoryGirl.create(:item, report: @report)
    # Create report 2
    FactoryGirl.create(:report, user: @admin)
    FactoryGirl.create(:item, report: @report)
    
    visit reports_path
    page.find(:xpath, "//table").all(:xpath, ".//tr").length.should == (1 + 1)
  end
end